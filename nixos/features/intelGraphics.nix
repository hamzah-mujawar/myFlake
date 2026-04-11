{inputs, ...}: {
  flake.nixosModules.intelGraphics = {pkgs, ...}: {
  	boot.kernelModules = ["i915"];
	services.xserver.videoDrivers = [ "modesetting" ];
	environment.sessionVariables = {
	    LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
	};
	hardware = {
		enableRedistributableFirmware = true;
		graphics = {
			enable = true;
			enable32Bit = true;
			extraPackages = with pkgs; [
				intel-media-driver
				intel-compute-runtime
				vpl-gpu-rt
				mesa
				];
		  	};
	 	 };
	  };
}
