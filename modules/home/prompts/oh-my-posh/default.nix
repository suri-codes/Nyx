{ config, lib, pkgs, ... }:
with lib;
let cfg = config.nyx.oh-my-posh;
in {

  options.nyx.oh-my-posh = { enable = mkEnableOption "Oh-My-Posh"; };

  config = mkIf (cfg.enable) {
    home.packages = [ pkgs.oh-my-posh ];

    home.file.".config/oh-my-posh/theme.toml".source = ./mypure.omp.toml;
  };

}
