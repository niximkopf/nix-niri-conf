{ config, pkgs, ... }:

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
      package = pkgs.runCommand "hoshino-ai-pixel-cursors" {} ''
        mkdir -p $out/share/icons/hoshino-ai-pixel-cursors
        cp -r ${./assets/cursor/hoshino-ai-pixel-cursors}/* $out/share/icons/hoshino-ai-pixel-cursors/
      '';
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
