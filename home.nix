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
}
