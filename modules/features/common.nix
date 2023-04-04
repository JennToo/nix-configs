{ config, pkgs, ... }:
{ 
  imports = [
    ../programs/tmux.nix
    ../programs/neovim.nix
  ];

  environment.systemPackages = with pkgs; [
    curl
    difftastic
    fd
    fzf
    git
    htop
    ripgrep
    tree
    wget
  ];
}
