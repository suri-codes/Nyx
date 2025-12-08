{ config, ... }:
let

  OOS = path: config.lib.file.mkOutOfStoreSymlink path;

in {

  # imports = [ ./apps ];
  #
  imports = [

    ../../modules/home

    ../../modules/home/prompts/oh-my-posh
    ../../modules/home/shells/zsh
    ../../modules/home/term/ghostty
    ../../modules/home/tools

  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.file = {
    # REMEMBER to lift the config file out, and refacts this after kenric puts his config
    # on the public internet, study and refactor my dotfiles!
    "Library/Application Support/com.mitchellh.ghostty".source =
      OOS "${config.home.homeDirectory}/dev/dots/apps/ghostty";

  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.05";
}

