{ config, pkgs, ... }:
let
	userName = config.home.username;
	containers = config.programs.zen-browser.profiles.${userName}.containers;
	spaces = {
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
		"💩" = {
			id = "d70529b0-6895-4c32-a5a9-1d7df4305543";
			position = 3000;
			icon = "💩";
			container = containers.google.id;
		};
	};
in
{
	programs.zen-browser.profiles.${userName}= {
		spacesForce = true;
		spaces = spaces;
	};
}
