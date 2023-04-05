{ config, pkgs, ... }:
{ 
  environment.systemPackages = with pkgs; [
    qalculate-gtk
  ];

  services.xserver.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
