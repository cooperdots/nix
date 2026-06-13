{
	self,
	inputs,
	...
}: {
	flake.nixosModules.duoguffinConfiguration = {
		pkgs,
		lib,
		...
	}: {
		wsl.enable = true;
		wsl.defaultUser = "coop";
		networking.hostName = "duoguffin";
		time.timeZone = "America/Chicago";

		nix.settings.experimental-features = [
			"nix-command"
			"flakes"
		];
		nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

		users.users.coop = {
			isNormalUser = true;
			shell = pkgs.nushell;
		};
		security.sudo.wheelNeedsPassword = true;

		programs.git = {
			enable = true;
			config = {
				user.name = "Cooper b. Anderson";
				user.email = "cooper@cooperuser.dev";
			};
		};

		environment.systemPackages = with pkgs; [
			git
			ghq
			lazygit

			fish
			nushell
			carapace

			neovim
			tmux

			ripgrep
			fd
			htop
			gcc

			# LSP servers and formatters
			lua-language-server
			stylua

			nixd
			alejandra
		];

		system.stateVersion = "26.05";
	};
}
