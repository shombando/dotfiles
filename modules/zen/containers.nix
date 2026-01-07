{ config, pkgs, ... }:
let
  userName = config.home.username;
  containers = {
    #colors: "blue", "turquoise", "green", "yellow", "orange", "red", "pink", "purple", "toolbar".
    proton = {
      color = "purple";
      icon = "circle";
      id = 1;
    };
    fedi = {
      color = "pink";
      icon = "circle";
      id = 2;
    };
    local = {
      color = "yellow";
      icon = "circle";
      id = 3;
    };
    vps = {
      color = "turquoise";
      icon = "circle";
      id = 4;
    };
    google = {
      color = "orange";
      icon = "circle";
      id = 5;
    };
    sc = {
      color = "yellow";
      icon = "circle";
      id = 6;
    };
    bradley = {
      color = "red";
      icon = "circle";
      id = 7;
    };
    tidal = {
      color = "toolbar";
      icon = "circle";
      id = 8;
    };
    gitforges = {
      color = "green";
      icon = "circle";
      id = 9;
    };
    ebay = {
      color = "blue";
      icon = "circle";
      id = 10;
    };
  };
in
{
  programs.zen-browser.profiles.${userName}= {
    containersForce = true;
    containers = containers;
  };
}
