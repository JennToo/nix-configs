{ config, pkgs, ... }: {
  networking.networkmanager.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.xwayland.enable = true;

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
    gnomeExtensions.appindicator
  ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  users.users.jwilcox = { packages = with pkgs; [ discord spotify ]; };
}
