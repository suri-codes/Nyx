{ pkgs, stdenv, ... }:

{
  home.file.".aerospace.toml" =
    pkgs.lib.mkIf pkgs.stdenv.isDarwin { source = ./aerospace.toml; };
}
