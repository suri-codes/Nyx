{ lib, pkgs, config, ... }:
with lib;
let cfg = config.nyx.ghostty;
in {
  options.nyx.ghostty = { enable = mkEnableOption "Ghostty Terminal"; };

  config = mkIf (cfg.enable) {
    home.file = {

      "${config.home.homeDirectory}/.config/ghostty".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/Nyx/modules/home/term/ghostty/ghostty";

    };
  };
}

