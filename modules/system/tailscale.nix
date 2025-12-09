{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.nyx.tailscale;
in
{

  options.nyx.tailscale = {
    enable = mkEnableOption "Tailscale";
  };

  config = mkIf (cfg.enable) {

    services.tailscale.enable = true;

    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };

  };

}
