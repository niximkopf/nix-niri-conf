{ pkgs, ... }:

{
  # aktivieren
  programs = {
    zsh.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    niri.enable = true;
  };

  networking = {
    hostName = "nix-btw";
    networkmanager.enable = true;
    firewall = {
      enable          = true;
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
    };
  };

  # ── AMD GPU (RX 9070 XT) ─────────────────────────────────────
  services = {
    xserver = {
    	videoDrivers     = [ "amdgpu" ];
    };

    gvfs.enable = true;
    #getty.autologinUser = "micha";

    power-profiles-daemon.enable = true;
    upower.enable = true;
  
    displayManager = {
      sddm = {
        enable          = true;
        wayland.enable  = true;
      };
      sessionPackages = [ pkgs.niri ];
    };

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
