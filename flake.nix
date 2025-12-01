{
  description = "My Nixos setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11"; # nixpkgs is shortcut for github:nixos/nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # prevent home manager from pulling its own packages and keep everything consistent
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # .nixos here is the host name from the config file
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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
