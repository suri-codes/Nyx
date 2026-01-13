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

    home.packages = with pkgs; [ fish ];

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

        "ld" = "eza -ld */ --no-quotes --time-style long-iso";
        "lla" = "eza -lah --no-quotes --time-style long-iso";
        "ll" = "eza -lh --no-quotes --time-style long-iso";
        "llr" = "eza -lhr --no-quotes --time-style long-iso";
        "lls" = "eza -lh -s size --no-quotes --time-style long-iso";
        "llt" = "eza -lh -s time --no-quotes --time-style long-iso";
        "lltr" = "eza -lhr -s time --no-quotes --time-style long-iso";

        "ree" = "sudo nixos-rebuild switch --flake ~/dots/nixdots#zephryus && git push";

        "fcd" =
          ''cd "$(find ~/coding/ ~/storage/ -type d -not \( -path "*/.git/*" -o -path "*/target/*" -o -path "*/.venv/*" -o -path "*/node_modules/*" -o -path "*/venv/*" -o -path "*/build/*" -o -path "*/.*/*" \) -print 2>/dev/null | fzf)" '';

        "l" = "exa";

        "lg" = "lazygit";
      };

      shellAbbrs = {
        # cargo abbreviations
        cb = "cargo build";
        cc = "cargo check";
        cdo = "cargo doc --open";
        cr = "cargo run";

        # git abbreviations
        gaa = "git add -A";
        ga = "git add";
        gbd = "git branch --delete";
        gb = "git branch";
        gc = "git commit";
        gcm = "git commit -m";
        gcob = "git checkout -b";
        gco = "git checkout";
        gd = "git diff";
        gl = "git log";
        gp = "git push";
        gpom = "git push origin main";
        gs = "git status";
        gst = "git stash";
        gstp = "git stash pop";

      };

      functions = {

        # TODO: figure out how this is supposed to work, rn need to call it twice for it to
        # use argument
        mkcd = ''
          function mkcd --argument name
          	mkdir -p $name
          	cd $name
          end
        '';
        # re = ''
        #   set VERSION (math (readlink /nix/var/nix/profiles/system | grep -o "[0-9]*") + 1)
        #   z ~/dots/nixdots
        #   git add -A
        #   git commit -m "Generation: $VERSION"
        #   sudo nixos-rebuild switch --flake /home/suri/dots/nixdots#zephryus
        #   git push
        # '';

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
