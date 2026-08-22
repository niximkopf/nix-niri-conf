{
  description = "Nixos-niri Konfiguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, catppuccin, ... }: {
    nixosConfigurations = {

      nix-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs   = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.micha = {
                imports = [
                  catppuccin.homeManagerModules.catppuccin
                  (import ./home.nix)
                ];
              };
            };
          }
        ];
      };
    };
  };
}