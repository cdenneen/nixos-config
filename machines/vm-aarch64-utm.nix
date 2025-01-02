{ config, pkgs, modulesPath, ... }: {
  imports = [
    ./hardware/vm-aarch64-utm.nix
    ./vm-shared.nix
  ];

  # Interface is this on my M1
  networking.interfaces.enp0s10.useDHCP = true;

  # Qemu
  services.davfs2.enable = true;
  services.dbus.packages = with pkgs; [ gnome2.GConf ];
  services.quemuGuest.enable = true;
  services.spice-vdagentd.enable = mkSure true;

  # For now, we need this since hardware acceleration does not work.
  environment.variables.LIBGL_ALWAYS_SOFTWARE = "1";

  # Lots of stuff that uses aarch64 that claims doesn't work, but actually works.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
}
