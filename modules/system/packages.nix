{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ── System Tools ──────────────────────────────────────────
    git
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
    impala
    wiremix
    ncdu
    lazygit
    discordo

    # ── Design ───────────────────────────────────────────────
    cava
    cmatrix
    cbonsai
    noctalia
    openrgb
    vial

    # ── Entwicklung ───────────────────────────────────────────
    vscode
    python3
    gcc
    gnumake
    quickshell

    # ── Apps ──────────────────────────────────────────────────
    brave
    (discord.override { withVencord = true; })
    nautilus
    spotify
    win2xcur
    modrinth-app

    # ── Editor ────────────────────────────────────────────────
    neovim
    libreoffice

    # ── Media ─────────────────────────────────────────────────
    mpv
    yt-dlp
    vlc
    tauon
    cmus

    ];
}
