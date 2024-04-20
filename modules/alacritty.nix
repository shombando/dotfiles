{pkgs, pkgs-unstable, ...}: {
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
        startup_mode = "Maximized";
      };

      scrolling.history = 10000;

      font = {
        normal.family = "JetBrains Mono";
        bold.family = "JetBrains Mono";
        italic.family = "JetBrains Mono";
        size = 16;
      };

      window.opacity = 0.85;

      keyboard.bindings = [
        {
          action = "ToggleViMode";
          key = "Space";
          mode = "~Search";
          mods = "Control";
        }
        {
          action = "SpawnNewInstance";
          key = "N";
          mods = "Shift|Control";
        }
        {
          action = "ToggleFullScreen";
          key = "Return";
          mods = "Alt";
        }
      ];
    };
  };
}
