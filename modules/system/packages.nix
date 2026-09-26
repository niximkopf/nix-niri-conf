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
    pciutils
    usbutils
    lshw
    nix-tree
    nvd
    qbittorrent

    # ── Terminal Tools ─────────────────────────────────
    eza
    bat
    ripgrep
    fd
    dust
    procs
    zoxide
    fzf
    delta
    gitui
    atuin
    zellij
    btop
    opencode
    croc
    bluetui
    wiremix
    ncdu
    lazygit
    file

    # ── Design ───────────────────────────────────────────────
    sddm-astronaut
    bibata-cursors
    fastfetch
    cava
    cmatrix
    noctalia
    openrgb
    vial
    (pkgs.callPackage ../../pkgs/momoisay { })
    kitty-themes

    # ── Entwicklung ───────────────────────────────────────────
    python3
    gcc
    gnumake
    quickshell

    # ── Apps ──────────────────────────────────────────────────
    brave-origin
    firefox
    (discord.override { withVencord = true; })
    nemo-with-extensions
    win2xcur
    modrinth-app
    localsend
    easyeffects

    # ── Editor ────────────────────────────────────────────────
    neovim
    libreoffice
    krita
    blender
    obsidian
    vscode

    # ── Media ─────────────────────────────────────────────────
    mpv
    yt-dlp
    rmpc
    mpc
    (pkgs.callPackage ../../pkgs/aniworld { })
    ];
}