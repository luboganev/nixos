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

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
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

    devShells.${system}.default = let
      pkgs = import nixpkgs { system = system; };
    in pkgs.mkShell {
      packages = [
        pkgs.gh
        pkgs.gcc
        pkgs.python3
        pkgs.uv # project/package manager https://docs.astral.sh/uv/
        pkgs.jq # command-line JSON processor
        pkgs.go
        pkgs.nodejs
        pkgs.nodePackages.typescript
      ];
      shellHook = ''
        export PATH=$PATH:$HOME/go/bin
        echo "Welcome to your dev shell with gcc, python, go, node and typescript"
      '';
    };
  };
}
