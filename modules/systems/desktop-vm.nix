{ config, pkgs, ... }:
{
  imports =
    [
      ../hardware-configurations/desktop-vm.nix

      ../features/common.nix
      ../features/gui-common.nix
      ../features/gnome-desktop.nix
      ../features/ssh-server.nix
      ../features/bash-developer.nix
      ../features/python-developer.nix
      ../features/music.nix
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


  system.stateVersion = "22.11";
}
