{ lib, pkgs, config, ... }:
with lib;
let cfg = config.nyx.ghostty;
in {
  options.nyx.ghostty = { enable = mkEnableOption "Ghostty Terminal"; };

  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    home.packages = [ pkgs.ghostty-bin ];

    home.file = {
      # REMEMBER to lift the config file out, and refacts this after kenric puts his config
      # on the public internet, study and refactor my dotfiles!

      "${config.home.homeDirectory}/.config/ghostty".source =
        config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/Nyx/ghostty";

    };
  };
}

