{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
	};

	outputs = { self, nixpkgs, nixos-wsl, ... } @ inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				nixos-wsl.nixosModules.default
				{
					system.stateVersion = "24.05";
					wsl.enable = true;
				}
				# nixos-wsl.nixosModules.wsl
				./wsl.nix
			];
		};
	};
}
