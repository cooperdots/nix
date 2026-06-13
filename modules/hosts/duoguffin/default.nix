{
	self,
	inputs,
	...
}: {
	flake.nixosConfigurations.duoguffin =
		inputs.nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = {inherit inputs;};
			modules = [
				inputs.nixos-wsl.nixosModules.default
				{
					system.stateVersion = "26.05";
					wsl.enable = true;
				}
				self.nixosModules.duoguffinConfiguration
			];
		};
}
