{
  description = "Jennifer's NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    musnix.url = "github:musnix/musnix";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations.desktop-vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.musnix.nixosModules.musnix
        inputs.home-manager.nixosModules.home-manager
        {
          boot.loader.grub.enable = true;
          boot.loader.grub.device = "/dev/vda";
          boot.loader.grub.useOSProber = true;
          networking.hostName = "nixos";
        }

        ./modules/hardware-configurations/desktop-vm.nix
        ./modules/features/common.nix
        ./modules/features/gui-common.nix
        ./modules/features/gnome-desktop.nix
        ./modules/features/ssh-server.nix
        ./modules/features/bash-developer.nix
        ./modules/features/python-developer.nix
        ./modules/features/music.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
