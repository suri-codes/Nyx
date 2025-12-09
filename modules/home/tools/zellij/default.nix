{ lib, pkgs, config, ... }:

with lib;
let
  cfg = config.nyx.zellij;

suri_zellij_session_helper =
    pkgs.writeShellScriptBin "suri_zellij_session_helper" ''
      ZELLIJ_SESSIONS=$(${pkgs.zellij}/bin/zellij ls | ${pkgs.gnused}/bin/sed 's/\x1b\[[0-9;]*m//g' | ${pkgs.coreutils}/bin/cut -d ' ' -f 1)
      NUM_SESSIONS=$(${pkgs.coreutils}/bin/echo "''${ZELLIJ_SESSIONS}" | ${pkgs.coreutils}/bin/wc -l )
      if [ "''${NUM_SESSIONS}" -ge 1 ]; then
        SESSION="$(${pkgs.coreutils}/bin/echo "''${ZELLIJ_SESSIONS}" | ${pkgs.fzf}/bin/fzf)"
        ${pkgs.zellij}/bin/zellij a ''${SESSION}
      else 
        ${pkgs.zellij}/bin/zellij attach -c
      fi
    '';  
in {

  options.nyx.zellij = { enable = mkEnableOption "Zellij"; };

  config = mkIf (cfg.enable) {
    home.file.".config/zellij/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/Nyx/modules/home/tools/zellij/config.kdl";
    home = { packages = [ pkgs.zellij pkgs.fzf suri_zellij_session_helper ]; };

  };

}
