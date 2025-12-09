{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.nyx.oh-my-posh;
in
{

  options.nyx.oh-my-posh = {
    enable = mkEnableOption "Oh-My-Posh";
  };

  config = mkIf (cfg.enable) {
    home.packages = [ pkgs.oh-my-posh ];

    home.file.".config/oh-my-posh/theme.toml".source =
      config.lib.file.mkOutOfStoreSymlink

        "${config.home.homeDirectory}/Nyx/modules/home/prompts/oh-my-posh/mypure.omp.toml";
  };

}
