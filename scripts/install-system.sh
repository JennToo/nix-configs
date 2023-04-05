#!/usr/bin/env bash

set -eux

SYSTEM="$1"

[ -e "modules/systems/$SYSTEM.nix" ]

if ! [ -e /etc/nixos/nix-configs ]
then
    sudo ln -s $(pwd) /etc/nixos/nix-configs
fi

cp /etc/nixos/configuration.nix "./configuration-old-$RANDOM.nix"
cat <<EOF | sudo tee /etc/nixos/configuration.nix
{ config, pkgs, ... }:
{
  imports =
    [
      ./nix-configs/modules/systems/$SYSTEM.nix
    ];
}
EOF
