{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];

  homebrew = {
    enable = true;
    casks  = [
      "1password"
      "amazon-chime"
      "amazon-photos"
      "arc"
      "brave-browser"
      "cleanshot"
      "discord"
      "google-chrome"
      "hammerspoon"
      "hiddenbar"
      "imageoptim"
      "istat-menus"
      "itsycal"
      "jumpcut"
      "keybase"
      "keycastr"
      "maccy"
      "megasync"
      "monodraw"
      "raycast"
      "rectangle"
      "screenflow"
      "session-manager-plugin"
      "slack"
      "spotify"
      "synology-drive"
      "teamviewer"
    ];
  };

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.cdenneen = {
    home = "/Users/cdenneen";
    shell = pkgs.zsh;
  };
}
