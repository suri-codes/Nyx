{ lib, pkgs, config, ... }:
with lib;
let cfg = config.nyx.orbstack;
in {
  options.nyx.orbstack = { enable = mkEnableOption "Orbstack "; };

  config = mkIf (cfg.enable) {

    home.packages = [ pkgs.orbstack ];

  };

}
