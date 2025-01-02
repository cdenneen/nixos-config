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
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;

  systemd.user.services.spice-agent = { 
    enable = true;
    wantedBy = ["graphical-session.target"]; 
    serviceConfig = { ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x"; }; 
    unitConfig = { ConditionVirtualization = "vm"; 
        Description = "Spice guest session agent"; 
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
    }; 
  };

  # For now, we need this since hardware acceleration does not work.
  environment.variables.LIBGL_ALWAYS_SOFTWARE = "1";

  # Lots of stuff that uses aarch64 that claims doesn't work, but actually works.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
}
