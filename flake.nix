{
  description = "Nixos-niri Konfiguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    driftwm.url = "github:malbiruk/driftwm";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, driftwm, ... }: {
    nixosConfigurations = {

      nix-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          home-manager.nixosModules.home-manager
          nvf.nixosModules.default
          driftwm.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs   = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.micha = {
                imports = [
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