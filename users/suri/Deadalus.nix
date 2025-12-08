{

  imports = [ ./common.nix ../../modules/home/wm/aerospace ];

  programs.aerospace.enable = true;
  programs.ghostty.enable = true;

}
