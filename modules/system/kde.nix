{ pkgs, ... }:

{
    services.desktopManager.plasma6.enable = true;

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        konsole
        elisa
        gwenview
        okular
        kate
        ark
        khelpcenter
        print-manager
        plasma-browser-integration
        dolphin
        dolphin-plugins
        kwalletmanager
        spectacle
        qrca
    ];
}