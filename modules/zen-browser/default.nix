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
	imports = [
		./searchEngines.nix
		./containers.nix
		./spaces.nix
		./pinnedTabs.nix
	];

	programs.zen-browser = {
		#https://github.com/0xc000022070/zen-browser-flake
		enable = true;
		nativeMessagingHosts = [pkgs.firefoxpwa];

		policies = {
			# POLICIES from about:policies#documentation
			AutofillAddressEnabled = lock-false;
			AutofillCreditCardEnabled = lock-false;
			DisableAppUpdate = lock-true;
			DisableFeedbackCommands = lock-true;
			DisableFirefoxStudies = lock-true;
			DisablePocket = lock-true;
			DisableTelemetry = lock-true;
			DontCheckDefaultBrowser = lock-true;
			NoDefaultBookmarks = lock-true;
			OfferToSaveLogins = lock-false;
			EnableTrackingProtection = {
				Value= lock-true;
				Locked = lock-true;
				Cryptomining = lock-true;
				Fingerprinting = lock-true;
			};
		};
	};
}
