{ config, pkgs, ... }: {
  imports = [ ../programs/xrdp-hyperv.nix ];
  services.xrdp-hyperv.enable = true;
  services.xrdp-hyperv.defaultWindowManager = "xfce4-session";
  boot.kernelModules = [ "hv_sock" ];

  services.xrdp-hyperv.package = pkgs.xrdp.overrideDerivation
    (attrs: { configureFlags = attrs.configureFlags ++ [ "--enable-vsock" ]; });
}
