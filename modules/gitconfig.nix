{ pkgs, ... }:
{
	programs.git = {
		enable = true;
		settings = {
			user = {
				name = "Shom Bandopadhaya";
				email = "shom@bandopadhaya.com";
				signingkey = "2231A3331BA5DF5B!";
			};
			init.defaultBranch = "main";
			commit.gpgsign = "true";
			merge.ff = "no";
			pull.rebase = "true";
			config = {
				credential.helper = "${
					pkgs.git.override { withLibsecret = true; }
				}/bin/git-credential-libsecret";
			};
		};
	};
}
