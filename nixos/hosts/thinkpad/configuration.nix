{ self, inputs, ... }: {
	flake.nixosConfigurations.thinkpad = inputs.nixpkgs.lib.nixosSystem {
   		 modules = [
      			self.nixosModules.thinkpadConfiguration
    			];
  	};
	flake.nixosModules.thinkpadConfiguration = { config, pkgs, ... }: {
	
	  imports =
	    [ # Include the results of the hardware scan.
		self.nixosModules.thinkpadHardware
		self.nixosModules.nix
		self.nixosModules.desktop
		self.nixosModules.niri
		self.nixosModules.emacs
		self.nixosModules.intelGraphics
		self.nixosModules.tmux
		self.nixosModules.helix
		self.nixosModules.nvf
	    ];
	  
	  # Bootloader.
	  boot.loader.systemd-boot.enable = true;
	  boot.loader.efi.canTouchEfiVariables = true;

	  # Use latest kernel.
	  boot.kernelPackages = pkgs.linuxPackages_latest;

	  boot.extraModprobeConfig = ''
	  	options snd-hda-intel dmic_detect=0
	  '';


	  networking.hostName = "carp"; # Define your hostname.
	  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	  # Enable networking
	  networking.networkmanager.enable = true;


	  # Enable CUPS to print documents.
	  services.printing.enable = true;


	  # Define a user account. Don't forget to set a password with ‘passwd’.
	  users.users.hamzah = {
	    isNormalUser = true;
	    description = "hamzah";
	    extraGroups = [ "networkmanager" "wheel" ];
	    shell = self.packages.${pkgs.system}.environment; # This is where we include environment.nix
	    packages = with pkgs; [
	    #  thunderbird
	    ];
	  };


	  # List packages installed in system profile. To search, run:
	  # $ nix search wget
	  environment.systemPackages = with pkgs; [
	     neovim 
	     wget
 	     adwaita-icon-theme
	     git
	     hunspell
	     hunspellDicts.en_GB-ise
	     gnat
	  ];


	  # Some programs need SUID wrappers, can be configured further or are
	  # started in user sessions.
	  # programs.mtr.enable = true;
	  # programs.gnupg.agent = {
	  #   enable = true;
	  #   enableSSHSupport = true;
	  # };

	  # List services that you want to enable:

	  # Enable the OpenSSH daemon.
	  # services.openssh.enable = true;

	  # Open ports in the firewall.
	  # networking.firewall.allowedTCPPorts = [ ... ];
	  # networking.firewall.allowedUDPPorts = [ ... ];
	  # Or disable the firewall altogether.
	  # networking.firewall.enable = false;

	  # This value determines the NixOS release from which the default
	  # settings for stateful data, like file locations and database versions
	  # on your system were taken. It‘s perfectly fine and recommended to leave
	  # this value at the release version of the first install of this system.
	  # Before changing this value read the documentation for this option
	  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	  system.stateVersion = "25.11"; # Did you read the comment?
	};
}
