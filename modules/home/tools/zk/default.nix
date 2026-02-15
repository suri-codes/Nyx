{
  config,
  lib,
  ...
}:

{

  programs.zk = {
    enable = true;
  };

  home.file.".config/zk/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.HomeDirectory}/Nyx/modules/home/tools/zk/config.toml";

}
