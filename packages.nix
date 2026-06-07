{ config, lib, pkgs, inputs, ... }: {
	environment.systemPackages = with pkgs; [
		git
		ghq
		lazygit

		fish
		nushell
		carapace

		neovim
		tmux

		htop
	];
}
