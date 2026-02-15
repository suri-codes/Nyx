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
    lib.file.MkOutOfStoreSymlink "${config.home.HomeDirectory}/Nyx/modules/home/tools/zk/config.toml";

}
