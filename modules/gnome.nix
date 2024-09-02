{ config, pkgs, lib, ... }:
let

in {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    dconf
  ];

  # https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/system/location" = {
      enabled = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };

   "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = true;
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

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces=4;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      toggle-maximized = ["<Super>m"];
      move-to-workspace-left = ["<Super><Alt>j"];
      move-to-workspace-right = ["<Super><Alt>k"];
      switch-to-workspace-left = ["<Super><Control>j"];
      switch-to-workspace-right = ["<Super><Control>k"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Super><Control>Escape"];
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
