{ config, pkgs, ... }:
let
  nixAliases = {
    nupdate			= "nix flake update";
    nsysbuild		= "sudo nixos-rebuild switch --flake .#vm";
    nhomebuild	= "home-manager switch --flake .";
  };
in {
  programs.bash = {
    enable = true;
    shellAliases = nixAliases;
  };

  # ZSH is available system wide, but I want home.nix to be portable
	programs.zsh = {
		enable = true;
    shellAliases = nixAliases;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
	};
}
