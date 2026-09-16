{ config, pkgs, ... }:

let
  hoshino-cursors = pkgs.stdenvNoCC.mkDerivation {
    pname = "hoshino-ai-pixel-cursors";
    version = "1.0";
    src = ./assets/hoshino-ai-pixel-cursors.tar.xz;
    dontUnpack = false;  # tar.xz wird automatisch entpackt, da erkanntes Format
    installPhase = ''
      mkdir -p $out/share/icons/hoshino-ai-pixel-cursors
      cp -r hoshino-ai-pixel-cursors/* $out/share/icons/hoshino-ai-pixel-cursors/
    '';
  };
in

{
  imports = [
    ./modules/config/shell.nix
    ./modules/config/alacritty.nix
    ./modules/config/git.nix
    ./modules/config/starship.nix
    ./modules/config/fastfetch
  ];

  home = {
    username      = "micha";
    homeDirectory = "/home/micha";
    stateVersion  = "25.11";

    pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      package = hoshino-cursors;
      name = "hoshino-ai-pixel-cursors";
      size = 24;
    };   
  };

  xdg = {
    configFile = {
    "niri/config.kdl".source = ./modules/config/niri-config.kdl;
    #"noctalia/config.toml".source = ./moduels/design/noctalia-config.toml;
    };

    enable = true;
    userDirs = {
  	  enable = true;
	  createDirectories = true;
	  setSessionVariables = true;
    };
  };

  # GTK-Theming
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "violet";
      };
    };
  };

  programs.home-manager.enable = true;

}
