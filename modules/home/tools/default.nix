{ pkgs, lib, ... }: {

  imports = [ ./helix ./zellij ];

  home.sessionVariables.LIBRARY_PATH =
    "${lib.makeLibraryPath [ pkgs.libiconv ]}\${LIBRARY_PATH:+:$LIBRARY_PATH}";

  home.packages = with pkgs; [

    fastfetch
    zoxide
    zstd
    coreutils-prefixed
    lazygit
    docker
    yazi
    fzf
    github-cli
    dust
    glow
    just
    typst
    tokei
    ripgrep
    bat

  ];

}
