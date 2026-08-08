{ pkgs, lib, ... }:

{
  # ── Asus Kontrolle ──────────────────────────────────────────
  services.asusd = {
    enable            = true;
  };

  # ── OpenRGB ─────────────────────────────────────────────────
  services.hardware.openrgb.enable = true;

  # ── i2c (RAM RGB + Board Controller) ────────────────────────
  hardware.i2c.enable = true;

  # ── Kernel Module ───────────────────────────────────────────
  boot.kernelModules = [ "asus-wmi" "i2c-dev" "i2c-piix4" ];

  # ── Wasserkühlung & Sensoren ────────────────────────────────
  environment.systemPackages = with pkgs; [
    asusctl
    liquidctl
    lm_sensors
  ];

  hardware.sensor.iio.enable = true;

  # ── udev Regeln ─────────────────────────────────────────────
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0b05", MODE="0666", GROUP="plugdev"
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
}
