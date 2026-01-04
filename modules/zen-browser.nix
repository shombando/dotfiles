{ config, pkgs, ... }:

let
  userName = config.home.username;
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.zen-browser = {
    #https://github.com/0xc000022070/zen-browser-flake
		enable = true;
    nativeMessagingHosts = [pkgs.firefoxpwa];

    policies = {
      # POLICIES from about:policies#documentation
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
		};

    profiles = {
      ${userName} = {
        search = {
          force = true;
          default = "Qwant";
          order = [ "Qwant" "DuckDuckGo" "Wikipedia (en)" ];
          engines = {
            "Amazon.com".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "eBay".metaData.alias = "@e";
            "Wikipedia (en)".metaData.alias = "@w";

            "Qwant" = {
              urls = [{
                template = "https://qwant.com";
                params = [
                  { name = "q"; value = "{searchTerms}"; }
                ];
              }];
              definedAliases = [ "@q" ];
            };

            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "channel"; value = "unstable"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [{
                template = "https://nixos.wiki/index.php";
                params = [{ name = "search"; value = "{searchTerms}"; }];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nw" ];
            };
          };
        };

        # MULTI-CONTAINER https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.containers
        containersForce = true;
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
        };
        spacesForce = true;
        spaces = 
          let
            containers = config.programs.zen-browser.profiles.${userName}.containers;
          in {
            "😎" = {
              id = "c6de089c-410d-4206-961d-ab11f988d40a";
              position = 1000;
              icon = "😎";
              container = containers.vps.id;
            };
            "🔒" = {
              id = "cdd10fab-4fc5-494b-9041-325e5759195b";
              position = 2000;
              icon = "🔒";
              container = containers.proton.id;
            };
          };

        pinsForce = true;
        pins =
          let 
            containers = config.programs.zen-browser.profiles.${userName}.containers;
            spaces = config.programs.zen-browser.profiles.${userName}.spaces;
            vpsFolderId = "ee36875c-bb6f-4c01-b562-ecff45cecc84";
          in {
            "mail" = {
              id = "be4ca61d-bff7-408a-acdb-a95075feb63f";
              container = containers.proton.id;
              workspace = spaces."🔒".id;
              url = "https://mail.proton.me/u/0/inbox";
              position = 101;
            };
            "tidal" = {
              id = "3ec27e62-ce9f-479b-a1a2-9f9a7ad4996c";
              container = containers.tidal.id;
              workspace = spaces."😎".id;
              url = "https://tidal.com";
              position = 100;
            };
            "readeck" = {
              id = "b044a63b-ef46-429b-ae15-14e78c578078";
              container = containers.fedi.id;
              workspace = spaces."😎".id;
              url = "https://readeck.shom.dev";
              position = 101;
            };
            "phanpy" = {
              id = "eeebd670-c879-4dfb-b015-6c472e965b98";
              container = containers.fedi.id;
              workspace = spaces."😎".id;
              url = "https://social.shom.dev";
              position = 900;
            };
            "vps" = {
              id = vpsFolderId;
              container = containers.vps.id;
              workspace = spaces."😎".id;
              isGroup = true;
              isFolderCollapsed = true;
              editedTitle = true;
              position = 001;
            };
            "uptime" = {
              id = "d8c602c1-938a-45dc-8cb0-69f9335b4562";
              container = containers.vps.id;
              workspace = spaces."😎".id;
              folderParentId = vpsFolderId;
              url = "https://status.shom.dev";
              position = 201;
            };
            "ntfy" = {
              id = "cef1c204-14f8-4ddb-8fbc-9dc363f0f921";
              container = containers.vps.id;
              workspace = spaces."😎".id;
              folderParentId = vpsFolderId;
              url = "https://ntfy.shom.dev";
              position = 202;
            };
            "umami" = {
              id = "a41a1aaf-67c2-44af-b4d6-e373ae6cfb1a";
              container = containers.vps.id;
              workspace = spaces."😎".id;
              folderParentId = vpsFolderId;
              url = "https://umami.shom.dev";
              position = 203;
            };
          };
      };
	  };
	};
}
