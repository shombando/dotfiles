{ config, pkgs, ... }:

	let
		nixAliases = {
			nupdate			= "nix flake update";
			nsysbuild		= "sudo nixos-rebuild switch --flake .#vm";
			nhomebuild	= "home-manager switch --flake .";
		};

	in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shom";
  home.homeDirectory = "/home/shom";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
		zsh
		bat
		ripgrep
		firefox
		emacs
		cool-retro-term
		htop
		tealdeer
		inxi
		neofetch
    alacritty
    neovim


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".gitconfig".source = ./config/.gitconfig;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/nvim/init.vim".text = ''
set number
set showmatch
set ignorecase
set hlsearch
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
"set cc=80
syntax enable
"set cursorline
set spell
'';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shom/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

	programs.bash = {
		enable = true;
		shellAliases = nixAliases;
	};

	programs.zsh = {
		enable = true;
		shellAliases = nixAliases;
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
