{ config, pkgs, ... }:

let
	userName = config.home.username;
	searchEngines = {
		amazondotcom-us.metaData.hidden = true;
		bing.metaData.hidden = true;
		google.metaData.hidden = true;
		perplexity.metaData.hidden = true;
		ebay.metaData.alias = "@e";
		wikipedia.metaData.alias = "@w";

		hister = {
			urls = [{
				template = "http://localhost:4433";
				params = [
					{ name = "q"; value = "{searchTerms}"; }
				];
			}];
			definedAliases = [ "@h" ];
		};

		qwant = {
			urls = [{
				template = "https://qwant.com";
				params = [
					{ name = "q"; value = "{searchTerms}"; }
				];
			}];
			definedAliases = [ "@q" ];
		};

		nixPackages = {
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

		nixHomeManagerOptions = {
			urls = [{
				template = "https://home-manager-options.extranix.com";
				params = [{ name = "query"; value = "{searchTerms}"; }];
			}];
			icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
			definedAliases = [ "@no" ];
		};

		nixWiki = {
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
		default = "hister";
		order = [ "hister" "qwant" "ddg" "wikipedia" ];
		engines = searchEngines;
	};
}
