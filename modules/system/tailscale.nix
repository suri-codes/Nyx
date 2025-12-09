{
  lib,
  config,
  ...
}:
{

  services.tailscale = {
    enable = true;

    openFirewall = true;
    authKeyFile = "/var/lib/secrets/tailscale_key";

  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
  };

}
