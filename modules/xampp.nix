{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    services.xampp = {
      enable = mkEnableOption "XAMPP-like LAMP stack";
      
      documentRoot = mkOption {
        type = types.str;
        default = "/var/www/html";
        description = "Document root for Apache";
      };

      phpVersion = mkOption {
        type = types.package;
        default = pkgs.php;
        description = "PHP package to use";
      };

      enablePhpMyAdmin = mkOption {
        type = types.bool;
        default = true;
        description = "Enable phpMyAdmin";
      };
    };
  };

  config = mkIf config.services.xampp.enable {
    # MariaDB/MySQL
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      settings = {
        mysqld = {
          bind-address = "127.0.0.1";
          port = 3306;
        };
      };
    };

    # PHP z rozszerzeniami
    environment.systemPackages = with pkgs; [
      (config.services.xampp.phpVersion.withExtensions ({ enabled, all }: enabled ++ (with all; [
        mysqli
        pdo
        pdo_mysql
        mbstring
        curl
        gd
        zip
        xml
        json
        intl
        session
      ])))
      mariadb
      apacheHttpd
    ] ++ lib.optionals config.services.xampp.enablePhpMyAdmin [ pkgs.phpmyadmin ];

    # Apache HTTP Server z PHP
    services.httpd = {
      enable = true;
      enablePHP = true;
      phpPackage = config.services.xampp.phpVersion.withExtensions ({ enabled, all }: enabled ++ (with all; [
        mysqli
        pdo
        pdo_mysql
        mbstring
        curl
        gd
        zip
        xml
        json
        intl
        session
      ]));
      adminAddr = "admin@localhost";
      
      virtualHosts."localhost" = {
        documentRoot = config.services.xampp.documentRoot;
        extraConfig = ''
          <Directory "${config.services.xampp.documentRoot}">
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
          </Directory>

          ${lib.optionalString config.services.xampp.enablePhpMyAdmin ''
            Alias /phpmyadmin ${pkgs.phpmyadmin}/share/phpmyadmin
            <Directory ${pkgs.phpmyadmin}/share/phpmyadmin>
              Options FollowSymLinks
              DirectoryIndex index.php
              AllowOverride All
              Require all granted

              <IfModule mod_php.c>
                php_flag magic_quotes_gpc Off
                php_flag track_vars On
                php_admin_flag allow_url_fopen On
                php_value include_path .
                php_admin_value upload_tmp_dir /tmp
                php_admin_value open_basedir ${pkgs.phpmyadmin}/share/phpmyadmin:/tmp:${config.services.xampp.documentRoot}
              </IfModule>
            </Directory>
          ''}
        '';
      };

      phpOptions = ''
        display_errors = On
        error_reporting = E_ALL
        memory_limit = 256M
        upload_max_filesize = 64M
        post_max_size = 64M
        max_execution_time = 300
        date.timezone = "Europe/Warsaw"
      '';
    };

    # Utwórz katalog dokumentów
    systemd.tmpfiles.rules = [
      "d ${config.services.xampp.documentRoot} 0755 wwwrun wwwrun -"
      "d /var/lib/phpmyadmin 0750 wwwrun wwwrun -"
    ];

    # Konfiguracja phpMyAdmin
    environment.etc."phpmyadmin/config.inc.php" = mkIf config.services.xampp.enablePhpMyAdmin {
      text = ''
        <?php
        $cfg['blowfish_secret'] = '${builtins.hashString "sha256" "nixos-xampp-secret"}';
        
        $i = 0;
        $i++;
        $cfg['Servers'][$i]['auth_type'] = 'cookie';
        $cfg['Servers'][$i]['host'] = 'localhost';
        $cfg['Servers'][$i]['compress'] = false;
        $cfg['Servers'][$i]['AllowNoPassword'] = true;
        
        $cfg['UploadDir'] = '/tmp';
        $cfg['SaveDir'] = '/tmp';
        $cfg['TempDir'] = '/tmp';
        ?>
      '';
    };

    # Informacja po aktywacji systemu
    system.activationScripts.xamppInfo = stringAfter [ "etc" ] ''
      echo "=========================================="
      echo "XAMPP-like stack is enabled!"
      echo "Apache: http://localhost"
      ${lib.optionalString config.services.xampp.enablePhpMyAdmin ''
      echo "phpMyAdmin: http://localhost/phpmyadmin"
      ''}
      echo "MySQL: localhost:3306"
      echo "Document root: ${config.services.xampp.documentRoot}"
      echo "=========================================="
    '';
  };
}
