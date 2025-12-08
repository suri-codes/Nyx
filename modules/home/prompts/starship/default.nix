{ lib, home, ... }: {

  programs.starship = {
    enable = true;

    settings =
      lib.mkForce (builtins.fromTOML (builtins.readFile ./starship.toml));
  };
  # home.file.".config/starship.toml".source = lib.mkForce ./starship.toml;

}
