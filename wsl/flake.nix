{
  description = "Home Manager configuration of mvaldes";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
         nixos-system = import ./configuration.nix;
    in
    {
      homeConfigurations."nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home-wsl.nix ];
      };
     nixosConfigurations = {
      x86_64-linux = nixos-system "x86_64-linux";
    };
    };
}
