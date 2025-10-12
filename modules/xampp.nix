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

      mysqlRootPassword = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "MySQL root password (null = no password for development)";
      };
    };
  };

  config = mkIf config.services.xampp.enable {
    # MariaDB/MySQL
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      ensureDatabases = [ ];
      ensureUsers = [ ];
      settings = {
        mysqld = {
          bind-address = "127.0.0.1";
          port = 3306;
        };
      };
    };

    # Apache HTTP Server z PHP
    services.httpd = {
      enable = true;
      enablePHP = true;
      phpPackage = config.services.xampp.phpVersion;
      adminAddr = "admin@localhost";
      
      virtualHosts."localhost" = {
        documentRoot = config.services.xampp.documentRoot;
        extraConfig = ''
          <Directory "${config.services.xampp.documentRoot}">
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
          </Directory>
        '';
      };

      phpOptions = ''
        display_errors = On
        error_reporting = E_ALL
        memory_limit = 256M
        upload_max_filesize = 64M
        post_max_size = 64M
        max_execution_time = 300
      '';
    };

    # phpMyAdmin
    services.phpmyadmin = {
      enable = true;
    };

    # Utwórz katalog dokumentów
    systemd.tmpfiles.rules = [
      "d ${config.services.xampp.documentRoot} 0755 wwwrun wwwrun -"
    ];

    # Otwórz porty w firewall (opcjonalne, dla dostępu z sieci lokalnej)
    # networking.firewall.allowedTCPPorts = [ 80 3306 ];

    # Dodaj PHP z rozszerzeniami
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
      ])))
      mariadb
      apacheHttpd
    ];

    # Informacja po aktywacji systemu
    system.activationScripts.xamppInfo = ''
      echo "=========================================="
      echo "XAMPP-like stack is enabled!"
      echo "Apache: http://localhost"
      echo "phpMyAdmin: http://localhost/phpmyadmin"
      echo "MySQL: localhost:3306"
      echo "Document root: ${config.services.xampp.documentRoot}"
      echo "=========================================="
    '';
  };
}
