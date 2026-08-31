{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
   
    nixvim = {
      url = "github:nix-community/nixvim";
     }; 
    niri-glass = {
      url = "https://gh.xmly.dev/https://github.com/zaroutt/Niri-glass/archive/master.tar.gz";
    };
     caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

};
  
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./chinese.nix
        ./shell.nix
        ./distro.nix
        inputs.niri-glass.nixosModules.default
        # Home Manager 作为 NixOS 模块
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.nixos = import ./home/nixos/default.nix; 
        }
      ];
    };
  };
 }
