{ pkgs, lib, ... }:
{

  imports = [
    ./helix
    ./zellij
    ./git.nix
    ./btop.nix
  ];

  # home.sessionVariables.LIBRARY_PATH = "${
  # lib.makeLibraryPath [ pkgs.libiconv ]
  # }\${LIBRARY_PATH:+:$LIBRARY_PATH}";

  home.packages = with pkgs; [
    jujutsu

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

  ];

}
