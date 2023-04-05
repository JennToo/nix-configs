{ config, pkgs, ... }:
{
  imports =
    [
      ../../../hardware-configuration.nix

      ../features/common.nix
      ../features/gui-common.nix
      ../features/gnome-desktop.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos";

  users.users.jwilcox = {
    isNormalUser = true;
    description = "Jennifer";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  services.openssh.enable = true;

  system.stateVersion = "22.11";
}
