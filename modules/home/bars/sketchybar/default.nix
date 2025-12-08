{ ... }: {
  home.file.".config/sketchybar/".source = ./sketchybar;
  # home.file.".config/sketchybar/".source = builtins.fetchGit {
  #   url = "https://github.com/zphrs/sketchybar-config";
  #   rev = "2545e7bab0c41577a8bcabc783c17e0593100182";
  # };

  # home.file.".config/sketchybar/".source = ./sketchybar-config;
  # home.file.".config/sketchybar/"

}
