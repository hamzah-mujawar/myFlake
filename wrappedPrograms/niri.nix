{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
	
        prefer-no-csd = null;
	extraConfig = ''
						hotkey-overlay {
							skip-at-startup
						}
						animations {
							slowdown 1.5
						}
						cursor {
						    xcursor-theme "Adwaita"
						    xcursor-size 15
						}
						window-rule {
							geometry-corner-radius 10
							clip-to-geometry true
							draw-border-with-background false
						}
		      '';


        input = {
          focus-follows-mouse = null;

          keyboard = {
            xkb = {
              layout = "us";
            };
            repeat-rate = 40;
            repeat-delay = 250;
          };

          touchpad = {
            natural-scroll = null;
            tap = null;
          };

          mouse = {
            accel-profile = "flat";
          };
        };

        binds = {
		"Mod+Shift+Slash" = {
			show-hotkey-overlay = _: { };
		};
		"Mod+Shift+E" = {
			quit = _: { };
		};
		"Mod+Return".spawn-sh = lib.getExe self'.packages.kitty;
		"Mod+Q".close-window = _: { };
		"Mod+Shift+F" = {
			fullscreen-window = _: { };
		};
		"Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
		
		"XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
		"XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

		"Mod+1".focus-workspace = 1;
		"Mod+2".focus-workspace = 2;
		"Mod+3".focus-workspace = 3;
		"Mod+4".focus-workspace = 4;
		"Mod+5".focus-workspace = 5;
		"Mod+6".focus-workspace = 6;
		"Mod+7".focus-workspace = 7;
		"Mod+8".focus-workspace = 8;
		"Mod+9".focus-workspace = 9;
		"Mod+0".focus-workspace = 0;

		"Mod+Shift+1".move-column-to-workspace = 1;
		"Mod+Shift+2".move-column-to-workspace = 2;
		"Mod+Shift+3".move-column-to-workspace = 3;
		"Mod+Shift+4".move-column-to-workspace = 4;
		"Mod+Shift+5".move-column-to-workspace = 5;
		"Mod+Shift+6".move-column-to-workspace = 6;
		"Mod+Shift+7".move-column-to-workspace = 7;
		"Mod+Shift+8".move-column-to-workspace = 8;
		"Mod+Shift+9".move-column-to-workspace = 9;
		"Mod+Shift+0".move-column-to-workspace = 0;
		
		"Mod+H".focus-column-left = _:{ };
		"Mod+L".focus-column-right = _:{ };
		"Mod+K".focus-window-or-workspace-up = _:{ };
		"Mod+J".focus-window-or-workspace-down = _:{ };

		"Mod+Left".focus-column-left = _:{ };
		"Mod+Right".focus-column-right = _:{ };
		"Mod+Up".focus-window-up = _:{ };
		"Mod+Down".focus-window-down = _:{ };

		"Mod+Shift+H".move-column-left = _:{ };
		"Mod+Shift+L".move-column-right = _:{ };
		"Mod+Shift+K".move-window-up-or-to-workspace-up = _:{ };
		"Mod+Shift+J".move-window-down-or-to-workspace-down = _:{ };
		
		"Mod+Shift+Minus".set-window-height = "-10%";
		"Mod+Shift+Equal".set-window-height = "+10%";

		"Mod+Minus".set-column-width = "-10%";
		"Mod+Equal".set-column-width = "+10%";

		"Mod+V".toggle-window-floating = _:{ };
		"Mod+Shift+V".switch-focus-between-floating-and-tiling = _:{ };
		
		"Mod+F".maximize-column = _:{ };
		"Mod+C".center-column = _:{ };
		"Mod+O".toggle-overview = _:{ };
		
		"Mod+BracketLeft".consume-or-expel-window-left = _:{ };
		"Mod+BracketRight".consume-or-expel-window-right = _:{ };
				
        };

	layout = {
		gaps = 16;
		background-color = "transparent";
		center-focused-column = "never";
		preset-column-widths = [
			{
				proportion = 0.3333;
			}
			{
				proportion = 0.5;
			}
			{
				proportion = 0.6667;
			}
		];
		default-column-width = [
			{
				proportion = 0.5;
			}	
		];
		focus-ring = {
			off = _:{ };
		};
		border = {
			width = 3;
			active-color = "#ffc87f";
			inactive-color = "505050";
			urgent-color = "#9b0000";
		};	
	};
      };
    };
  };
}
