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
        ca = "cargo add";
        cr = "cargo run";
        cb = "cargo build";
        cc = "cargo check";
        cdo = "cargo doc --open";

        # jujutsu abbreviations
        jja = "jj abandon";
        jjn = "jj new";
        jjd = "jj describe";
        jje = "jj edit";
        jjf = "jj file";
        jjl = "jj log";
        jjs = "jj squash";

        jju = "jj undo";
        jjr = "jj redo";

        jjrb = "jj rebase";

        jjdf = "jj diff";

        jjbc = "jj bookmark create";
        jjbm = "jj bookmark move";
        jjbl = "jj bookmark list";
        jjbt = "jj bookmark track";

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
          disown
          sleep 1  # Give Typst some time to generate the PDF
          open "$output_file"  # Open the generated PDF
        '';

        # init a dev template
        dti = ''
          set lang $argv[1]

          if test (count $argv) -eq 0
              echo "Usage: dti <template-name>"
              return 1
          end

          nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$lang"
          jj git init
          jj describe -m "feat: Init"
        '';

        # create a new dev template project
        dtn = ''

          if test (count $argv) -eq 0 
              echo "Usage: dtn <proj_dir> <template-name>"
              return 1
          end

          set proj_dir $argv[1]
          set lang $argv[2]

          nix flake new --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$lang" $proj_dir
          cd $proj_dir
          jj git init
          jj describe -m "feat: Init $proj_dir"


        '';
      };
    };
  };
}
