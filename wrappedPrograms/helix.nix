{ self, inputs, ... }:{
	flake.nixosModules.helix = { pkgs, lib, ... }: {
		programs.helix = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHelix;
		};
	};
	perSystem = { pkgs, lib, self', ... }: {
		packages.myHelix = inputs.wrapper-modules.wrappers.tmux.wrap {
			inherit pkgs;
			languages =  [
				{
					name = "c++";
					auto-format = false;
					language-server = { command = "ccls", args = [] };
				}
			]
		};
	};
}


