{ self, inputs, ... }: {
	flake.nixosModules.tmux = { pkgs, lib, ... }: {
		programs.tmux = {
			enable = true;
			package = self.packages.${pkgs.stdenv.hostPlatform.system}.myTmux;
		};
	};
	perSystem = { pkgs, lib, self', ... }:{
		packages.myTmux = inputs.wrapper-modules.wrappers.tmux.wrap {
			inherit pkgs;
			sourceSensible = true;
			terminal = "kitty";
			vimVisualKeys = true;
			shell = "${self'.packages.environment}/bin/fish";
			prefix = "C-Space";
			modeKeys = "vi";
			plugins = { 
				'christoomey/vim-tmux-navigator'
			};
			
        	};
	};
}
