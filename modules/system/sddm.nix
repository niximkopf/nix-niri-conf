{ config, pkgs, lib, ... }:

let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
  };

in {
  services.displayManager = {
    sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "weston";
      };
      autoNumlock = true;
      enableHidpi = true;
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
          CursorTheme = "mornye-wuwa-cursors";
          CursorSize = 36;
        };
      };
      extraPackages = with pkgs; [
        custom-sddm-astronaut
      ];
    };
    sessionPackages = [ pkgs.niri ];
    defaultSession = lib.mkForce "niri";
  };

  environment.systemPackages = with pkgs; [
    custom-sddm-astronaut
    kdePackages.qtmultimedia
    (pkgs.callPackage ../../pkgs/cursor/mornye-wuwa-cursors { })
  ];
}