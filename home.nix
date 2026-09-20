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
      package = pkgs.callPackage ./pkgs/cursor/mornye-wuwa-cursors { };
      name = "mornye-wuwa-cursors";
      size = 36;
    };   
  };

  xdg = {
    #stateFile."noctalia/settings.toml".source = ./assets/noctalia/settings.toml;
    configFile = {
    "niri/config.kdl".source = ./modules/config/niri-config.kdl;
    #"noctalia/config.toml".source = ./assets/noctalia/config.toml;
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
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = [ "lavender" ];
        size = "standard";
      };
    };
    gtk4.extraCss = ''
      @import url("noctalia.css");
      @import 'colors.css';
    '';
    gtk4.theme = null;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "violet";
      };
    };
  };

  #gtk3.extraConfig = {
  #  gtk-application-prefer-dark-theme = 1;
  #  gtk-theme-name = "Adwaita";
  #};
  #gtk4.extraConfig = {
  #  gtk-application-prefer-dark-theme = 1;
  #};

  programs.home-manager.enable = true;

}
