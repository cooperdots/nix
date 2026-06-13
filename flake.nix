{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
		fenix = {
			url = "github:nix-community/fenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		nixpkgs,
		nixos-wsl,
		fenix,
		...
	} @ inputs: {
		packages.x86_64-linux.default = fenix.packages.x86_64-linux.default.toolchain;
		nixosConfigurations.duoguffin =
			nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = {inherit inputs;};
				modules = [
					nixos-wsl.nixosModules.default
					{
						system.stateVersion = "26.05";
						wsl.enable = true;
					}
					./configuration.nix
					./packages.nix
					./rust.nix
				];
			};
	};
}
