{
	pkgs,
	...
}: let
	unstable-packages = with pkgs.unstable; [
		neovim
		tmux

		git
		ghq
		lazygit

		htop
		eza
	];

	stable-packages = with pkgs; [
		gh
	];
in {
	home.stateVersion = "22.11";
	home = {
		username = "coop";
		homeDirectory = "/home/coop";

		sessionVariables.EDITOR = "nvim";
	};

	home.packages =
		stable-packages
		++ unstable-packages
		++ [];
}
