{ config, pkgs, ... }:

{
  # ... reszta konfiguracji ...

  # Włącz Apache (httpd)
  services.httpd = {
    enable = true;
    enablePHP = true;
    
    # Dodatkowe moduły Apache
    extraModules = [ "proxy_fcgi" ];
    
    # Konfiguracja phpMyAdmin
    virtualHosts."localhost" = {
      documentRoot = "${pkgs.phpmyadmin}/share/phpmyadmin";
      
      extraConfig = ''
        <Directory "${pkgs.phpmyadmin}/share/phpmyadmin">
          DirectoryIndex index.php
          AllowOverride All
          Require all granted
        </Directory>
      '';
    };
  };

  # Włącz MySQL/MariaDB
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    
    # Opcjonalnie: ustaw początkowe bazy danych
    ensureDatabases = [ "testdb" ];
    ensureUsers = [{
      name = "testuser";
      ensurePermissions = {
        "testdb.*" = "ALL PRIVILEGES";
      };
    }];
  };

  # Dodaj phpMyAdmin do pakietów systemowych
  environment.systemPackages = with pkgs; [
    phpmyadmin
  ];
}
