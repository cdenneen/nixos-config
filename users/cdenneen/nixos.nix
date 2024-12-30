{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  # environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using zsh as our shell
  programs.zsh.enable = true;

  users.users.cdenneen = {
    isNormalUser = true;
    home = "/home/cdenneen";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$m57xh/c4gipjewT6$ovt9lGhsi.m6WHHUvrRYvbi8k63mSBnkxV3r2VNg9iJBL7sKYDGpovjDgk21cAmz44IOvwJek9eoytlEZGwi6/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAyhU3OsKXxtks9hUrNTcdNqAjmI70oUCTt+/kYsFfe7WbOYtiMKObG74MWZkr0ylqmRoh8eh3PeIgnydjrr8nn0XwuaLmzUR66JhIBODDTP0QYe/X0IUg9oFRTFf1c+3moFAqDjU8wscDQZ5GGvzPLqwld0B7XCFDJ/kA79srmik5ZVtLOu1gckNi4cdEWkZiHAWEDy9o6GXpgRAYFAt1jU6zSIXCmYb02NHg/6oo+1oJVDQIQsjBOMsJE0Qh+erAmu+Y/nf59hE6K8Yvw7NMcrG+3MOFY2mrJmG9ZvL9u0EqZMlXFL373nYHOVjChzbuc+RVCEC116JHqi77A9a+Dw== cdenneen"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];
}
