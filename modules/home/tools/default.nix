{ pkgs, lib, ... }:
{

  imports = [
    ./helix
    ./zellij
    ./zk
    ./git.nix
    ./btop.nix

  ];

  # home.sessionVariables.LIBRARY_PATH = "${
  # lib.makeLibraryPath [ pkgs.libiconv ]
  # }\${LIBRARY_PATH:+:$LIBRARY_PATH}";

  home.packages = with pkgs; [
    jujutsu

    zoxide
    eza
    fd

    ripgrep
    bat
    fastfetch
    zstd
    coreutils-prefixed
    nh
    yazi
    fzf
    github-cli
    dust
    glow
    just
    tokei
    libqalculate

    #NOTE: remove after memori
    rustup
    bun
    nodejs

    codex

  ];

}
