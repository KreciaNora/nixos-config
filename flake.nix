{
  description = "NixOs config - Krecikowa";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }:
  {
    nixosConfigurations = {

      # Laptop z NVIDIA
      laptop-nvidia = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hosts/laptop-nvidia
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.krecikowa = import ./home.nix;
            home-manager.backupFileExtension = "backup";
          }

          {
            environment.systemPackages = [
              zen-browser.packages.x86_64-linux.default
            ];
          }
        ];
      };

      # Laptop bez NVIDIA
      laptop-intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hosts/laptop-intel
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.krecikowa = import ./home.nix;
            home-manager.backupFileExtension = "backup";
          }

          {
            environment.systemPackages = [
              zen-browser.packages.x86_64-linux.default
            ];
          }
        ];
      };
    };
  };
}

