{ self, inputs, ... }:{
	flake.nixosModules.mpv = { pkgs, lib, ... }: {
		environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myMpv ];
	};
	perSystem = { pkgs, lib, self', ... }: {
		packages.myMpv = inputs.wrapper-modules.wrappers.mpv.wrap {
			inherit pkgs;
		};
	};
}


