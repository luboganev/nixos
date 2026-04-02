{ pkgs, ... }:

{
  home.username = "luboganev";
  home.homeDirectory = "/home/luboganev";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.kcalc
    keepassxc
    ghostty
    github-desktop
    discord
    vscode
    vim
    vlc
    yt-dlp # download from youtube and other platforms
    id3v2 # Command line editor for id3v2 tags
    # LibreOffice
    libreoffice-qt
    hunspell
    hyphenDicts.en_US
    hyphenDicts.de_DE
    # Gaming stuff
    protonup-ng # for updating proton GE for gaming
    mangohud # overlay for monitoring fps, temp etc.
    vulkan-tools # gpu tools
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Lyubomir Ganev";
        email = "luboganev@gmail.com";
      };
      init = {
        defaultBranch = "main";
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
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # for protonup command
  };
}
