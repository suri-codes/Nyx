{
  lib,
  config,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.nyx.fish;
in
{

  options.nyx.fish = {
    enable = mkEnableOption "Fish";
  };

  config = mkIf (cfg.enable) {

    home.file.".config/fish/conf.d/nix-env.fish".source = ./nix-fix.fish;

    programs.fish = {

      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        eval (ssh-agent -c) &> /dev/null
        ssh-add ~/.ssh/github &> /dev/null
        ssh-add ~/.ssh/ucsc_gitlab &> /dev/null

        eval "$(zoxide init fish)"

        direnv hook fish | source
        set -g direnv_fish_mode eval_on_arrow 

        COMPLETE=fish jj | source

        function starship_transient_prompt_func
          starship module character
        end
        starship init fish | source
        enable_transience
      '';

      shellAliases = {
        ".." = "cd ..";
      };

      shellAbbrs = {

        # personal abbrvs
        rr = "rm -rf";
        zh = "suri_zellij_session_helper";

        # cargo abbreviations
        cr = "cargo run";
        cb = "cargo build";
        cc = "cargo check";
        cdo = "cargo doc --open";

        # jujutsu abbreviations
        jjn = "jj new";
        jjd = "jj describe";
        jje = "jj edit";
        jjf = "jj file";
        jjl = "jj log";
        jjs = "jj squash";

        jju = "jj undo";
        jjr = "jj redo";

        jjrb = "jj rebase";

        jjbc = "jj bookmark create";
        jjbm = "jj bookmark move";
        jjbl = "jj bookmark list";

        jjgf = "jj git fetch";
        jjgp = "jj git push";

      };

      functions = {

        # yazi function that takes me to different directory when I exit.
        y = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if test -s "$tmp"
              set cwd (cat -- "$tmp")
              if test -n "$cwd" -a "$cwd" != "$PWD"
                  cd -- "$cwd"
              end
          end
          rm -f -- "$tmp" &> /dev/null

        '';

        # easy way to continuously compile and open a typst file.
        tz = ''
          if test (count $argv) -eq 0
              echo "Usage: tz <file.typ>"
              return 1
          end

          set input_file $argv[1]
          set output_file (string replace ".typ" ".pdf" -- $input_file)

          typst watch "$input_file" "$output_file" &  # Watch and compile Typst file
          sleep 1  # Give Typst some time to generate the PDF
          open "$output_file"  # Open the generated PDF
        '';
      };
    };
  };
}
