{ config, pkgs, ... }:
{ 
  environment.systemPackages = with pkgs; [
    qalculate-gtk
  ];
}
