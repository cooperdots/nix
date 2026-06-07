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

		ripgrep
		fd
		htop
		gcc

		# LSP servers and formatters
		lua-language-server
		stylua
	];
}
