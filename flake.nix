{
  description = "Nixos-niri Konfiguration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, ... }:
  let
    mkHost = hostPath: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        hostPath
        home-manager.nixosModules.home-manager
        nvf.nixosModules.default
        {
          home-manager = {
            useGlobalPkgs   = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.micha.imports = [ (import ./home.nix) ];
          };
        }
      ];
    };
  in
  {
    nixosConfigurations = {
      nix-btw = mkHost ./hosts/desktop;
      laptop  = mkHost ./hosts/laptop;
    };
  };
}