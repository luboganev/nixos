{ config, pkgs, ... }:

{
  home.username = "luboganev";
  home.homeDirectory = "/home/luboganev";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "Lyubomir Ganev";
    userEmail = "luboganev@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
    };
  };
}
