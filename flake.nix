{
	inputs = {
		# nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
		# nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

		home-manager.url = "github:nix-community/home-manager/release-24.05";
	};

	outputs = { self, nixpkgs, nixos-wsl, home-manager, ... } @ inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			# pkgs = nixpkgs-unstable;
			modules = [
				home-manager.nixosModules.home-manager
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
