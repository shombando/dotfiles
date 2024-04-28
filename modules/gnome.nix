{ config, pkgs, lib, ... }:
let

in {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    dconf
  ];

  #https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      text-scaling-factor = 1.5;
      enable-hot-corners = false;
    };

    "org/gnome/mutter" = {
      workspaces-only-on-primary = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = "uint32 3209";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = "disabled";
      enabled-extensions = [
        "pop-shell@system76.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "Alacritty.desktop"
        "emacsclient.desktop"
      ];
    };

    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      hint-color-rgba = "rgb(99,217,228)";
      active-hint-border-radius = "uint32 5";
      tile-by-default = true;
      gap-inner = "uint32 2";
      gap-outer = "uint32 2";
      mouse-cursor-follows-active-window = false;
      show-skip-taskbar = true;
      show-title = true;
      stacking-with-mouse = true;
    };
  };
}
