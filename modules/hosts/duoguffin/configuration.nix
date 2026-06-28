{inputs, ...}: {
	flake.nixosModules.duoguffinConfiguration = {pkgs, ...}: {
		imports = [
		];

		wsl.enable = true;
		wsl.defaultUser = "coop";
		networking.hostName = "duoguffin";
		time.timeZone = "America/Chicago";

		nix.settings.experimental-features = [
			"nix-command"
			"flakes"
		];
		nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
		nixpkgs.config.allowUnfree = true;

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

		nixpkgs.overlays = [
			inputs.rust-overlay.overlays.default
			inputs.claude-code.overlays.default
		];

		environment.systemPackages = with pkgs; [
			git
			ghq
			lazygit

			fish
			nushell
			carapace

			neovim
			tmux
			inputs.herdr.packages.x86_64-linux.herdr

			ripgrep
			fd
			htop
			gcc

			# Rust: change `nightly` to `stable` if this fails
			(rust-bin.nightly.latest.default.override {
					extensions = ["rust-src" "rust-analyzer"];
				})

			# Node
			bun

			# LSP servers and formatters
			lua-language-server
			stylua

			nixd
			alejandra

			# AI
			pkgs.claude-code
		];

		system.stateVersion = "26.05";
	};
}
