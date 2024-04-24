{
	description = "Systems Flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
	let
		# System Settings
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

		# User Settings
		username = "shom";
		name = "Shom Bandopadhaya";

	in {
		nixosConfigurations = {
			vm = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
        specialArgs = {
          inherit pkgs-unstable;
        };
			};
		};
		homeConfigurations = {
			shom = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
			};
		};
	};
}
