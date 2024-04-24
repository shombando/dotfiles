{pkgs, pkgs-unstable, ...}: {
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 5;
          y = 5;
        };
        startup_mode = "Maximized";
        opacity = 0.85;
      };

      scrolling.history = 10000;

      font = {
        normal.family = "JetBrains Mono";
        bold.family = "JetBrains Mono";
        italic.family = "JetBrains Mono";
        size = 16;
      };


      key_bindings = [
        {
          action = "ToggleViMode";
          key = "Space";
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
