HOST := $(shell hostname)

all: switch

switch:
	sudo nixos-rebuild switch --flake '.#$(HOST)'

format:
	find -name '*.nix' -exec nixfmt '{}' ';'
