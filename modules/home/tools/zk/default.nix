{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.nyx.oh-my-posh;
in
{
  options.nyx.zk = {
    enable = mkEnableOption "zk";

  };

  config = mkIf (cfg.enable) {

    programs.zk = {
      enable = true;
    };

    home.file.".config/zk/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.HomeDirectory}/Nyx/modules/home/tools/zk/config.toml";

  };

}
