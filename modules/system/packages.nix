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
    niri
    xwayland-satellite
    noctalia
    sddm-astronaut

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
    cmatrix
    cava
    cbonsai
    bluetui
    impala
    wiremix
    ncdu
    lazygit
    discordo

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
    kitty
    spotify
    win2xcur
    modrinth-app

    # ── Editor ────────────────────────────────────────────────
    neovim

    # ── Media ─────────────────────────────────────────────────
    mpv
    yt-dlp
    vlc
    tauon
    cmus

    # ── RGB ───────────────────────────────────────────────────
    openrgb
    vial
  ];
}
