{ self, inputs, ... }: {
	flake.nixosModules.thinkpadHardware = 	{ config, lib, pkgs, modulesPath, ... }: {
	  imports =
	    [ (modulesPath + "/installer/scan/not-detected.nix")
	    ];

	  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
	  boot.initrd.kernelModules = [ ];
	  boot.kernelModules = [ "kvm-intel" ];
	  boot.extraModulePackages = [ ];

	  fileSystems."/" =
	    { device = "/dev/disk/by-uuid/6f32e6ea-b726-40a6-b262-758eab81d9a3";
	      fsType = "ext4";
	    };

	  fileSystems."/boot" =
	    { device = "/dev/disk/by-uuid/A5F2-832B";
	      fsType = "vfat";
	      options = [ "fmask=0077" "dmask=0077" ];
	    };

	  swapDevices =
	    [ { device = "/dev/disk/by-uuid/f3e648d4-9131-4e11-9f2b-9a5adda0f382"; }
	    ];

	  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
	};
}
