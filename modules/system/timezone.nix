{ ... }:

{
  time.timeZone      = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME     = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
  };

  # Tastaturlayout
  services.xserver.xkb = {
    layout  = "us";
    variant = "";
  };
  console.keyMap = "us";
}
