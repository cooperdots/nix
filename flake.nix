{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
	};

	outputs = { self, nixpkgs, nixos-wsl, ... } @ inputs: {
		nixosConfigurations.duoguffin = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				nixos-wsl.nixosModules.default
				{
					system.stateVersion = "26.05";
					wsl.enable = true;
				}
				./configuration.nix
				./packages.nix
			];
		};
	};
}
