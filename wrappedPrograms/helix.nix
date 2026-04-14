{ self, inputs, ... }:{
	flake.nixosModules.helix = { pkgs, lib, ... }: {
		environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myHelix ];
	};
	perSystem = { pkgs, lib, self', ... }: {
		packages.myHelix = inputs.wrapper-modules.wrappers.helix.wrap {
			inherit pkgs;
		};
	};
}


