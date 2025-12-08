{ lib, pkgs, ... }:
with lib;

let cfg = config.programs.oh-my-posh;
in {
  config = mkIf (cfg.enable) { home.pakages = [ pkgs.oh-my-posh ]; };

  home.file.".config/oh-my-posh/theme.toml".source = ./mypure.omp.toml;

}
