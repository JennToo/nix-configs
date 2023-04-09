{ config, pkgs, ... }: {
  musnix.enable = true;
  environment.systemPackages = with pkgs; [
    ardour
    audacity
    cardinal
    carla
    dexed
    geonkick
    surge-XT
  ];
  users.users.jwilcox.extraGroups = [ "audio" ];
}
