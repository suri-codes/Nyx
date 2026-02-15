{
  config,
  ...
}:
{

  programs.zk = {
    enable = true;
  };

  home.file.".config/zk/config.toml".source =
    config.lib.file.MkOutOfStoreSymlink "${config.home.HomeDirectory}/Nyx/modules/home/tools/zk/config.toml";

}
