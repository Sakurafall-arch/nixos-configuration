{
  description = "NixOS flake-configuration for T2 MacBook";

  inputs = {
    nixpkgs.url = "https://gh.xmly.dev/https://github.com/nixos/nixpkgs/archive/nixos-unstable.tar.gz";
    nixos-hardware = {
      url = "https://gh.xmly.dev/https://github.com/NixOS/nixos-hardware/archive/refs/heads/master.tar.gz";
    };
    home-manager = {
      url = "https://gh.xmly.dev/https://github.com/nix-community/home-manager/archive/master.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    miyu = {
      url = "https://gh.xmly.dev/https://github.com/yigexuanmu/Miyu/archive/master.tar.gz";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./chinese.nix

        # T2 MacBook 硬件支持
        nixos-hardware.nixosModules.apple-t2

        # Home Manager 作为 NixOS 模块
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.nixos = import ./home/home.nix;
        }
      ];
    };
  };
}
