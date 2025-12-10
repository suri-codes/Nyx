{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {

      user = {
        name = "suri312006";
        email = "suri312006@gmail.com";
      };

      pull = {
        rebase = false;
      };

      init = {
        defaultBranch = "main";
      };
    };

    lfs = {
      enable = true;
    };

  };

  home.packages = [ pkgs.lazygit ];
}
