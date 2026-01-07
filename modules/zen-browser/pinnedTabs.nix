{ config, pkgs, ... }:

let
	userName = config.home.username;
	containers = config.programs.zen-browser.profiles.${userName}.containers;
	spaces = config.programs.zen-browser.profiles.${userName}.spaces;

	pinnedFolders = {
		vpsFolder = {
			id = "ee36875c-bb6f-4c01-b562-ecff45cecc84";
			container = containers.vps.id;
			workspace = spaces."😎".id;
			isGroup = true;
			isFolderCollapsed = true;
			editedTitle = true;
			position = 001;
		};
	};

	pins = {
		"mail" = {
			id = "be4ca61d-bff7-408a-acdb-a95075feb63f";
			container = containers.proton.id;
			workspace = spaces."🔒".id;
			url = "https://mail.proton.me/u/0/inbox";
			position = 101;
		};
		"calendar" = {
			id = "3251bb9c-6a39-4baf-9ef2-c2ca0d35742a";
			container = containers.proton.id;
			workspace = spaces."🔒".id;
			url = "https://calendar.proton.me/u/0/";
			position = 102;
		};
		"drive" = {
			id = "8d5e6952-cfae-4583-a955-225f02407584";
			container = containers.proton.id;
			workspace = spaces."🔒".id;
			url = "https://drive.proton.me/u/0/";
			position = 103;
		};
		"gmail" = {
			id = "839035d8-2e2d-43d9-89f8-dd07c73d3243";
			container = containers.google.id;
			workspace = spaces."💩".id;
			url = "https://mail.google.com";
			position = 100;
		};
		"voice" = {
			id = "0e2f4e37-80d5-4d97-a80d-43a8cd6093d0";
			container = containers.google.id;
			workspace = spaces."💩".id;
			url = "https://voice.google.com/u/0/messages";
			position = 101;
		};
		"youtube" = {
			id = "821083f5-5e9b-4c62-b82a-d301c05c1b30";
			container = containers.google.id;
			workspace = spaces."💩".id;
			url = "https://youtube.com";
			position = 102;
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
			container = containers.vps.id;
			workspace = spaces."😎".id;
			url = "https://readeck.shom.dev";
			position = 101;
		};
		"gts" = {
			id = "4ece24d9-a4df-4c41-96e0-ab3453c28eff";
			container = containers.fedi.id;
			workspace = spaces."😎".id;
			url = "https://gts.shom.dev/settings";
			position = 800;
		};
		"phanpy" = {
			id = "eeebd670-c879-4dfb-b015-6c472e965b98";
			container = containers.fedi.id;
			workspace = spaces."😎".id;
			url = "https://social.shom.dev";
			position = 900;
		};
		"vps" = pinnedFolders.vpsFolder;
		"uptime" = {
			id = "d8c602c1-938a-45dc-8cb0-69f9335b4562";
			container = containers.vps.id;
			workspace = spaces."😎".id;
			folderParentId = pinnedFolders.vpsFolder.id;
			url = "https://status.shom.dev";
			position = 201;
		};
		"ntfy" = {
			id = "cef1c204-14f8-4ddb-8fbc-9dc363f0f921";
			container = containers.vps.id;
			workspace = spaces."😎".id;
			folderParentId = pinnedFolders.vpsFolder.id;
			url = "https://ntfy.shom.dev";
			position = 202;
		};
		"umami" = {
			id = "a41a1aaf-67c2-44af-b4d6-e373ae6cfb1a";
			container = containers.vps.id;
			workspace = spaces."😎".id;
			folderParentId = pinnedFolders.vpsFolder.id;
			url = "https://umami.shom.dev";
			position = 203;
		};
	};
in {
	programs.zen-browser.profiles.${userName} = {
		pinsForce = true;
		pins = pins;
	};
}
