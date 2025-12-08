{ pkgs, config, ... }: {

  home.file.".config/helix/ignore".text = ''
    !.notes/
    !.gitignore
    !.gitmodules
    !.github/
    !.devcontainer/
    !.env*
    !.sqlx/
    !.cargo/
    !.config/
    !puzzles/*
    !examples/*
    !inputs/*
    target/
  '';

  # ignore file
  "${config.home.homeDirectory}/.config/helix/ignore".source =
    config.lib.file.mkOutOfStoreSymLink
    "${config.home.homeDirectory}/Nyx/modules/tools/helix/ignore";

  # theme file
  "${config.home.homeDirectory}/.config/helix/nyx-theme.toml".source =
    config.lib.file.mkOutOfStoreSymLink
    "${config.home.homeDirectory}/Nyx/modules/tools/helix/nyx-theme.toml";

  # config.toml
  "${config.home.homeDirectory}/.config/helix/config.toml".source =
    config.lib.file.mkOutOfStoreSymLink
    "${config.home.homeDirectory}/Nyx/modules/tools/helix/config.toml";

  # languages.toml
  "${config.home.homeDirectory}/.config/helix/languages.toml".source =
    config.lib.file.mkOutOfStoreSymLink
    "${config.home.homeDirectory}/Nyx/modules/tools/helix/languages.toml";

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
      python312Packages.python-lsp-server
      typescript-language-server
      svelte-language-server
      tailwindcss-language-server
      tinymist
      ltex-ls
      nixd
      nil
      codebook
      markdown-oxide
      ruff
    ];

  };
}
