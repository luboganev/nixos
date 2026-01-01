{ config, pkgs, ... }:

{
  home.username = "luboganev";
  home.homeDirectory = "/home/luboganev";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    keepassxc
    ghostty
    github-desktop
    discord
    vlc
    yt-dlp
    protonup-ng # for updating proton GE for gaming
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Lyubomir Ganev";
        email = "luboganev@gmail.com";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "echo Copying to dotfiles; cp /etc/nixos/* ~/nixos-dotfiles/; echo Doing rebuild switch...; sudo nixos-rebuild switch";
    };
  };

  home.sessionVariables = {
    STEAM_EXTRA_COMPACT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # for protonup command
  };
}
