{ ... }:

{

  imports = [ ../../modules/home ];

  # nyx.oh-my-posh.enable = true;
  nyx.starship.enable = true;
  # nyx.zsh.enable = true;
  nyx.fish.enable = true;
  nyx.zellij.enable = true;
  nyx.helix.enable = true;
  nyx.zk.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.05";
}
