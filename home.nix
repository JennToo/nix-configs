{ config, pkgs, ... }:
{
  home.username = "jwilcox";
  home.homeDirectory = "/home/jwilcox";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  services.gpg-agent = {                          
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.git = {
    enable = true;
    userName = "Jennifer Wilcox";
    userEmail = "jennifer@nitori.org";
    ignores = [
      "compile_commands.json"
      "/.vscode"
      "/.ezdebugger"
      "/.ccls-cache"
      "/.idea"
      ".bloop"
      ".metals"
      "/*.iml"
      "/project/metals.sbt"
      "/.clangd"
      "/.cache/clangd"
    ];
    difftastic.enable = true;
    extraConfig = {
      init.defaultbranch = "main";
      pull.rebase = "false";
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./dotfiles/bashrc;
  };
}
