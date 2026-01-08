{ ... }:
# EXTENSIONS from about:support for extension/add-on ID strings
# Valid strings for installation_mode are "allowed", "blocked",
# "force_installed" and "normal_installed".
let
  moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
  extensions = {
  # uBlock Origin
  "uBlock0@raymondhill.net" = {
    install_url = moz "ublock-origin";
    installation_mode = "force_installed";
    default_area = "navbar"; # pinned
  };

	# Bitwarden
	"{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
		install_url = moz "bitwarden-password-manager";
		installation_mode = "force_installed";
		default_area = "navbar"; # pinned
	};

	# Dark Reader
	"addon@darkreader.org" = {
		install_url = moz "darkreader";
		installation_mode = "force_installed";
	};

	# Vimium
	"{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
		install_url = moz "vimium-ff";
		installation_mode = "force_installed";
	};

	# Consent-O-Matic
	"gdpr@cavi.au.dk" = {
		install_url = moz "consent-o-matic";
		installation_mode = "force_installed";
	};

	# Firefox Multi-Account Containers
	"@testpilot-containers" = {
		install_url = moz "multi-account-containers";
		installation_mode = "force_installed";
	};
	"*".installation_mode = "blocked"; # blocks all addons except the ones specified
  };
in
{
	programs.zen-browser.policies = {
    ExtensionSettings = extensions;
	};
}
