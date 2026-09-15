{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── System Tools ──────────────────────────────────────────
    git
    nodejs
    wget
    curl
    unzip
    psmisc
    pciutils    # lspci
    usbutils    # lsusb
    lshw        # Hardware Info
    nix-tree    # Nix Abhängigkeiten visualisieren
    nvd         # Nix Version Diff
    xwayland-satellite
    sddm-astronaut
    bibata-cursors

    # ── Terminal Tools ─────────────────────────────────
    eza
    bat
    ripgrep
    fd
    dust
    procs
    zoxide
    fzf
    fastfetch
    delta
    gitui
    yazi
    atuin
    zellij
    btop
    opencode
    croc
    wtf
    bluetui
    wiremix
    ncdu
    lazygit

    # ── Design ───────────────────────────────────────────────
    cava
    cmatrix
    noctalia
    openrgb
    vial
    (pkgs.callPackage ../../pkgs/momoisay { })

    # ── Entwicklung ───────────────────────────────────────────
    vscode
    python3
    gcc
    gnumake
    quickshell
    obsidian
    blender

    # ── Apps ──────────────────────────────────────────────────
    brave-origin
    (discord.override { withVencord = true; })
    nautilus
    spotify
    win2xcur
    modrinth-app
    localsend

    libwacom
    xf86_input_wacom
    kdePackages.wacomtablet

    # ── Editor ────────────────────────────────────────────────
    neovim
    libreoffice
    krita

    # ── Media ─────────────────────────────────────────────────
    mpv
    yt-dlp
    vlc
    rmpc

    ];
}
