{ pkgs, ... }:

{
  users.users.micha = {
    isNormalUser = true;
    shell        = pkgs.zsh;
    extraGroups  = [
      "wheel"
      "networkmanager"
      "plugdev"
      "libvirtd"
      "video"
      "audio"
    ];
  };
}