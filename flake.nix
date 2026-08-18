{
  description = "My Nixos setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05"; # nixpkgs is shortcut for github:nixos/nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # prevent home manager from pulling its own packages and keep everything consistent
      inputs.nixpkgs.follows = "nixpkgs";
    };
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager, unstable-nixpkgs,... } @ inputs:
  let
    system = "x86_64-linux";
  in {
    # .nixos here is the host name from the config file
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        # build system based on that
        ./configuration.nix
        # use configured home-manager
        home-manager.nixosModules.home-manager
        {
          home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.luboganev = import ./home.nix;
              backupFileExtension = "backup"; # create backups instead of crashing if file exists
          };
        }
      ];
    };
  };
}
