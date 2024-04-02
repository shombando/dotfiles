{
	description = "Systems Flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }:
	let
		# System Settings
		system = "x86_64-linux";
		lib = nixpkgs.lib;
		pkgs = nixpkgs.legacyPackages.${system};

		# User Settings
		username = "shom";
		name = "Shom Bandopadhaya";

	in {
		nixosConfigurations = {
			vm = lib.nixosSystem {
				inherit system;

				modules = [ ./configuration.nix ];
			};
		};
		homeConfigurations = {
			shom = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix ];
			};
		};
	};
}
