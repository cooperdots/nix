{
	pkgs,
	inputs,
	...
}: {
	environment.enableAllTerminfo = true;

	# home-manager.users.coop = {};

	wsl = {
		enable = true;
		defaultUser = "coop";
	};

	nix = {
		settings = {
			trusted-users = ["coop"];
			accept-flake-config = true;
			auto-optimise-store = true;
		};

		registry = {
			nixpkgs = {
				flake = inputs.nixpkgs;
			};
		};

		nixPath = [
			"nixpkgs=${inputs.nixpkgs.outPath}"
			"nixos-config=/etc/nixos/configuration.nix"
			"/nix/var/nix/profiles/per-user/root/channels"
		];

		package = pkgs.nixFlakes;
		extraOptions = ''experimental-features = nix-command flakes'';

		gc = {
			automatic = true;
			options = "--delete-older-than 7d";
		};
	};

	environment.systemPackages = [
		pkgs.neovim
		pkgs.git
		pkgs.lazygit
	];
}
