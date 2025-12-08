{ pkgs, config, outputs, ... }: {

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # dont remove zellij and fzf, just trust me
  environment.systemPackages = with pkgs; [ vim git nh zellij fzf ];

  system.primaryUser = "suri";

  fonts.packages = [ pkgs.monaspace ];

  homebrew = {
    enable = true;
    brews = [
      "sketchybar"
      "mas"
      "borders"
      "libiconv"
      "ifstat"
      "libiconv"
      # for twizzler
      "qemu"
      "e2fsprogs"
      "spicetify-cli"
      "ninja"

    ];
    casks = [
      "ghostty@tip"
      "google-chrome"
      "db-browser-for-sqlite"

      "notion"
      "orbstack"
      "zen"
      "discord"
      "slack"
      "zulip"
      "raycast"
      "blender"
      "godot"
      "zoom"
      "soduto"
      "font-hack-nerd-font"
      "font-sf-pro"
      "font-fira-code-nerd-font"
      "spotify"
      "obsidian"
      "mac-mouse-fix"
    ];
    masApps = { "whatsapp" = 310633997; };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # cleanup = "zap";
    };
  };

  system.defaults = {
    dock.autohide = true;
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;
    # NSGlobalDomain._HIHideMenuBar = true; sketchy bar tmoapita to figure out rn
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    finder.FXPreferredViewStyle = "clmv";
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;
  # Set Git commit hash for darwin-version.
  system.configurationRevision = outputs.rev or outputs.dirtyRev or null;

  nixpkgs.config.allowUnfree = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  security.pam.services.sudo_local.touchIdAuth = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.suri = {
    name = "suri";
    home = "/Users/suri";
  };
}
