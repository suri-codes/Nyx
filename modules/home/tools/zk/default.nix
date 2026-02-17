{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.nyx.zk;
in
{
  options.nyx.zk = {
    enable = mkEnableOption "zk";

  };

  config = mkIf (cfg.enable) {

    programs.zk = {
      enable = true;
    };

    home.file.".config/zk/config.toml".text = ''
      [notebook]
      dir = "~/dev/personal/meditations"
    '';

  };

}
