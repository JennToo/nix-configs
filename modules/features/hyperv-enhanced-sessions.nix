{ config, pkgs, ... }: {
  imports = [ ../programs/xrdp-hyperv.nix ];
  services.xrdp-hyperv.enable = true;
  boot.kernelModules = [ "hv_sock" ];

  services.xrdp-hyperv.package = pkgs.xrdp.overrideDerivation
    (attrs: { configureFlags = attrs.configureFlags ++ [ "--enable-vsock" ]; });
}
