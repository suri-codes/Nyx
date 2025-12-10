{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.nyx.zsh;
  zsh_history_fix = pkgs.writeShellScriptBin "zsh_history_fix" ''
    mv ~/.zsh_history ~/.zsh_history_bad
    strings ~/.zsh_history_bad > ~/.zsh_history
    fc -R ~/.zsh_history
    rm ~/.zsh_history_bad

  '';
in
{

  options.nyx.zsh = {
    enable = mkEnableOption "Zsh";
  };

  config = mkIf (cfg.enable) {
    programs.zoxide.enable = true;
    home.packages = with pkgs; [
      fd
      eza
      zsh_history_fix
    ];
    programs.zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        eval `ssh-agent` &> /dev/null
        ssh-add ~/.ssh/github &> /dev/null

        eval "$(zoxide init zsh)"
        # eval "$(starship init zsh)"
        ${lib.optionalString pkgs.stdenv.isDarwin ''
          if [ -f /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
            export PATH="/opt/homebrew/opt/libiconv/bin:$PATH"
          fi
        ''}

        function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                    cd -- "$cwd"
            fi
            rm -f -- "$tmp"
        }

        function tz() {
            if [ -z "$1" ]; then
                echo "Usage: tz <file.typ>"
                return 1
            fi

            input_file="$1"
            output_file="''${input_file%.typ}.pdf"  # Replace .typ with .pdf

            typst watch "$input_file" "$output_file" &  # Watch and compile Typst file
            sleep 1  # Give Typst some time to generate the PDF
            open "$output_file"  # Open the generated PDF
        }

        export PATH="/Users/suri/.cargo/bin:$PATH" &> /dev/null

        eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config ${config.home.homeDirectory}/.config/oh-my-posh/theme.toml)"


      '';
    };
  };

}
