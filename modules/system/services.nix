{ pkgs, lib,  ... }:

{
  programs = {
    zsh.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    niri.enable = true;
  };

  services = {

    gvfs.enable = true;

    power-profiles-daemon.enable = true;
    upower.enable = true;

    pipewire = {
      enable        = true;
      alsa.enable   = true;
      alsa.support32Bit = true;
      pulse.enable  = true;
      jack.enable   = true;
    };
    pulseaudio.enable = false;
  };

  security.rtkit.enable      = true;

  hardware = {
    graphics = {
      enable      = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable      = true;
      powerOnBoot = true;
    };
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  # ── GPU Passthrough (später einrichten) ──────────────────────
  # virtualisation.libvirtd.enable = true;
  # virtualisation.libvirtd.qemu.ovmf.enable = true;
  # boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];
  # boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" ];
}
