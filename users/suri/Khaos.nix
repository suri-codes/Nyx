{ ... }:
{
  imports = [ ./common.nix ];

  nyx.oh-my-posh.enable = true;
  nyx.zsh.enable = true;
  nyx.zellij.enable = true;

  home.sessionVariables = {
    COLORTERM = "truecolor";
  };

}
