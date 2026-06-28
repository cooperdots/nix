{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

		flake-parts.url = "github:hercules-ci/flake-parts";
		import-tree.url = "github:vic/import-tree";

		wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

		rust-overlay = {
			url = "github:oxalica/rust-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		herdr = {
			url = "github:ogulcancelik/herdr";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
		inputs.flake-parts.lib.mkFlake
		{inherit inputs;}
		(inputs.import-tree ./modules);
}
