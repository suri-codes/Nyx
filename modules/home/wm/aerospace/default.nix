{ lib, pkgs, config, ... }:

with lib;
let cfg = config.programs.aerospace;
in {
  options.programs.aerospace = {
    enable = mkEnableOption "AeroSpace window manager";
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    home.packages = [ pkgs.aerospace ];

    home.file.".aerospace.toml".source = ./aerospace.toml;

    launchd.agents.aerospace = {
      enable = true;
      config = {
        ProgramArguments = [ "${pkgs.aerospace}/bin/aerospace" ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/aerospace.out.log";
        StandardErrorPath = "/tmp/aerospace.err.log";
      };
    };
  };
}
