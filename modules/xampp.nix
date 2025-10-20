{ config, pkgs, ... }:
{
  services.httpd = {
    enable = true;
    enablePHP = true;
    
    adminAddr = "admin@localhost";
    
    phpPackage = pkgs.php;
    
    phpOptions = ''
      error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
      display_errors = On
      display_startup_errors = On
      log_errors = On
      session.save_path = "/tmp"
      upload_tmp_dir = "/tmp"
    '';
    
    extraModules = [ "proxy_fcgi" ];
    
    virtualHosts."localhost" = {
      documentRoot = "/home/krecikowa/www";  # ← Twój katalog domowy
      
      extraConfig = ''
        <Directory "/home/krecikowa/www">
          DirectoryIndex index.php index.html
          AllowOverride All
          Require all granted
          Options Indexes FollowSymLinks
        </Directory>
        
        Alias /phpmyadmin /var/www/phpmyadmin
        
        <Directory "/var/www/phpmyadmin">
          DirectoryIndex index.php
          AllowOverride All
          Require all granted
        </Directory>
      '';
    };
  };
  
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    
    ensureDatabases = [ "testdb" ];
    ensureUsers = [{
      name = "testuser";
      ensurePermissions = {
        "testdb.*" = "ALL PRIVILEGES";
      };
    }];
  };
  
  environment.systemPackages = with pkgs; [
    mariadb
    apacheHttpd
    php
    wget
    unzip
  ];
}
