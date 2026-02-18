{ pkgs, outputs, ... }:
{

  imports = [

    ../../modules/system/fonts.nix

  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # dont remove zellij and fzf, just trust me
  environment.systemPackages = with pkgs; [
    vim
    git
    zellij
    fzf
  ];

  system.primaryUser = "suri";

  homebrew = {
    enable = true;

    brews = [
      "sketchybar"
      "mas"
      # terminal handling stuff
      # "libiconv"
      # nmcli kinda
      "ifstat"
      # spicetify stuff
      "spicetify-cli"

      # TODO: for twizzler, make a flake for ts
      "qemu"
      "e2fsprogs"
      "ninja"

    ];
    casks = [
      "ghostty@tip"
      "db-browser-for-sqlite"
      "zen"
      "zed"
      "discord"
      "slack"
      "zulip"
      "raycast"
      "zoom"
      "spotify"
      "zotero"
      "mac-mouse-fix"
      "tailscale-app"
      "GrandPerspective"
      "skim"
      "kicad"
    ];
    masApps = {
      "whatsapp" = 310633997;
    };
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

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.fish.enable = true;

  users.users.suri = {
    name = "suri";
    home = "/Users/suri";
    shell = pkgs.fish;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
