{ config, pkgs, ... }: {
  musnix.enable = true;
  environment.systemPackages = with pkgs; [
    ardour
    audacity
    cardinal
    carla
    dexed
    surge-XT
  ];
  users.users.jwilcox.extraGroups = [ "audio" ];
}
