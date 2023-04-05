{
  description = "Jennifer's NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs }: {

    nixosConfigurations.desktop-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/systems/desktop-vm.nix
      ];
    };

  };
}
