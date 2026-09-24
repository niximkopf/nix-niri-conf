{ pkgs-stable, ... }:

{
  environment.systemPackages = with pkgs-stable; [
    xwayland-satellite
  ];
}