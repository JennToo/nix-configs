{
  description = "Jennifer's NixOS configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    musnix.url = "github:musnix/musnix";
  };

  outputs = inputs: {
    nixosConfigurations.desktop-vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.musnix.nixosModules.musnix
        ./modules/systems/desktop-vm.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
