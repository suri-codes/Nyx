{ pkgs, config, ... }:

let

  rebuildCmd = if pkgs.stdenv.isDarwin then "darwin-rebuild" else "nixos-rebuild";

  flakeDir = "${config.home.homeDirectory}/Nyx";

  systemName = "$(hostname -s)";
in
{
  imports = [

    ./fish
    
    ./zsh

  ];

  home.shellAliases = {
    era = "sudo ${rebuildCmd} switch --flake ${flakeDir}#${systemName}";
    epoch = "cd ${flakeDir} && git add -A && git commit -m \".\" && sudo ${rebuildCmd} switch --flake .#${systemName} && git push";
    l = "exa";
    ls = "exa";
    lg = "lazygit";
    c = "clear";
    tars = "cd /Users/suri/dev/personal/tars/tars-tui && cargo run --release";
    ezk = " /Users/suri/dev/personal/Emergence/target/release/emergence_cli";
  };
}
