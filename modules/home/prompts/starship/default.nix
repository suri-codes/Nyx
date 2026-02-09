{ config, lib, ... }:

with lib;

let
  cfg = config.nyx.starship;
in
{

  options.nyx.starship = {
    enable = mkEnableOption "Starship";
  };

  config = mkIf (cfg.enable) {
    programs.starship = {
      enable = true;

      # settings = lib.mkForce (fromTOML (builtins.readFile ./starship.toml));
    };
    home.file.".config/starship.toml".source =

      config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/Nyx/modules/home/prompts/starship/starship.toml";

  };

}
