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

    home.packages = with pkgs; [
      fish
      fd
      eza
    ];

    home.file.".config/fish/conf.d/nix-env.fish".source = ./nix-fix.fish;

    programs.fish = {

      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        eval (ssh-agent -c) &> /dev/null
        ssh-add ~/.ssh/github &> /dev/null
        ssh-add ~/.ssh/ucsc_gitlab &> /dev/null

        eval "$(zoxide init fish)"
        eval "$(starship init fish)"

        enable_transience
      '';

      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";

        "dots" = "cd ~/dev/dots";

        "cp" = "cp -v";
        "ddf" = "df -h";
        "etc" = "erd -H";
        "mkdir" = "mkdir -p";
        "mv" = "mv -v";
        "rm" = "rm -v";
        "rr" = "rm -rf";

        "fcd" =
          ''cd "$(find ~/coding/ ~/storage/ -type d -not \( -path "*/.git/*" -o -path "*/target/*" -o -path "*/.venv/*" -o -path "*/node_modules/*" -o -path "*/venv/*" -o -path "*/build/*" -o -path "*/.*/*" \) -print 2>/dev/null | fzf)" '';

      };

      shellAbbrs = {
        # # cargo abbreviations
        cb = "cargo build";
        cc = "cargo check";
        cdo = "cargo doc --open";
        cr = "cargo run";

        # jujutsu abbreviations
        jjn = "jj new";
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
