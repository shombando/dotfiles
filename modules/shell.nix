{ config, pkgs, lib, ... }:
let
  shAliases = {
    nupdate			= "nix flake update";
    nsysbuild		= "sudo nixos-rebuild switch --flake .#vm";
    nhomebuild	= "home-manager switch --flake .";
    ndeletegens = "nix-collect-garbage -d";
    ndeleteupto = "nix-collect-garbage --delete-older-than=";

    gs = "git status";
    ga = "git add --all";
    gd = "git diff";
    gc = "git commit -m";
    gf = "git fetch";
    gF = "git pull";
    gp = "git push";
    gu = "ga && gc 'update' && gp";
    gl = "git log --graph  --abbrev-commit --date=relative --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
  };

in {
  home.packages = with pkgs; [
    zsh
    # spaceship-prompt
    bash
  ];

  programs.bash = {
    enable = true;
    shellAliases = shAliases;
  };

  # ZSH is available system wide, but I want home.nix to be portable
	programs.zsh = {
		enable = true;
    shellAliases = shAliases;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # autosuggestions.enable = true;
    # historySubstringSearch = true;
	};

  programs.zsh.plugins = [
    {
      # will source zsh-autosuggestions.plugin.zsh
      name = "zsh-autosuggestions";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-autosuggestions";
        rev = "v0.7.0";
        # sha256 = lib.fakeSha256;
        sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w";
      };
    }
    {
      # will source zsh-autosuggestions.plugin.zsh
      name = "zsh-history-substring-search";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-history-substring-search";
        rev = "v1.1.0";
        # sha256 = lib.fakeSha256;
        sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4";
      };
    }
    {
      # will source zsh-autosuggestions.plugin.zsh
      name = "spaceship-prompt";
      src = pkgs.fetchFromGitHub {
        owner = "spaceship-prompt";
        repo = "spaceship-prompt";
        rev = "v4.15.1";
        # sha256 = lib.fakeSha256;
        sha256 = "sha256-5nlku/JUs1YnchOGvsle7rF96b3DteMuxZhSzoNvDGY";
      };
    }
  ];
}
