{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.nyx.helix;
in
{

  options.nyx.helix = {
    enable = mkEnableOption "Helix text editor";
  };

  config = mkIf (cfg.enable) {

    # symlink files
    home.file.".config/helix".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Nyx/modules/home/tools/helix/helix";

    programs.helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        # markdown-oxide
        gopls
        nil
        texlab
        taplo
        lua-language-server
        haskell-language-server
        typescript-language-server
        svelte-language-server
        tailwindcss-language-server
        tinymist
        ltex-ls
        nixd
        nil
        codebook
        markdown-oxide
        fourmolu
        ruff
        harper
      ];

    };
  };
}
