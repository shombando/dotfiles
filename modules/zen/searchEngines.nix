{ config, pkgs, ... }:

let
	userName = config.home.username;
	searchEngines = {
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
in
{
	programs.zen-browser.profiles.${userName}.search = {
		force = true;
		default = "Qwant";
		order = [ "Qwant" "DuckDuckGo" "Wikipedia (en)" ];
		engines = searchEngines;
	};
}
