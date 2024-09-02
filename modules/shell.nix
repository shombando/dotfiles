{ config, pkgs, lib, ... }:
let
  shAliases = {
    #Dir and nav
    ls   = "eza --long --all --header --no-permissions --group-directories-first --smart-group --total-size";
    "~"  = "cd ~";
    ".." = "cd ..";
    cg   = "cd `git rev-parse --show-toplevel`";
    cat  = "bat";
    cp   = "xcp";

    #Git
    gs = "git status";
    ga = "git add --all";
    gd = "git diff";
    gc = "git commit -m";
    gf = "git fetch";
    gF = "git pull";
    gp = "git push";
    gu = "ga && gc 'update' && gp";
    gl = "git log --graph  --abbrev-commit --date=relative --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";

    #Nix
    nupdate			= "nix flake update";
    nsysbuild		= "sudo nixos-rebuild switch --flake .#vm";
    nhomebuild	= "home-manager switch --flake .";
    ndeletegens = "nix-collect-garbage -d";
    ndeleteupto = "nix-collect-garbage --delete-older-than=";
  };

in {
  home.packages = with pkgs; [
    bash
		bat
    curl
    eza
		htop
		inxi
    jq
		neofetch
    neovim
		ripgrep
    spaceship-prompt
		tealdeer
    tree
    xcp
    zsh
  ];

 programs.bash = {
    enable = true;
    shellAliases = shAliases;
  };

  # ZSH is available system wide, but I want home.nix to be portable
	programs.zsh = {
		enable = true;
    dotDir = ".config/zsh";
    shellAliases = shAliases;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down

source ${pkgs.spaceship-prompt}/lib/spaceship-prompt/spaceship.zsh
autoload -U promptinit; promptinit
'';

    plugins = [
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
        # will source zsh-history-substring-search.plugin.zsh
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.1.0";
          # sha256 = lib.fakeSha256;
          sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4";
        };
      }
    ];
  };
}
