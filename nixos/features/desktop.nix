{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.desktop = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.system}";
    zen = inputs.zen-browser.packages."${pkgs.system}".twilight;
  in {
    imports = [
      self.nixosModules.pipewire
    ];

    fonts.packages = with pkgs; [
      miracode
      nerd-fonts.jetbrains-mono
      ubuntu-sans
      cm_unicode
      corefonts
      unifont
    ];

    fonts.fontconfig.defaultFonts = {
      serif = ["Ubuntu Sans"];
      sansSerif = ["Ubuntu Sans"];
      monospace = ["Miracode"];
    };

    environment.variables.XCURSOR_SIZE = "15";
    # Set your time zone.

    time.timeZone = "Asia/Dubai";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ar_AE.UTF-8";
      LC_IDENTIFICATION = "ar_AE.UTF-8";
      LC_MEASUREMENT = "ar_AE.UTF-8";
      LC_MONETARY = "ar_AE.UTF-8";
      LC_NAME = "ar_AE.UTF-8";
      LC_NUMERIC = "ar_AE.UTF-8";
      LC_PAPER = "ar_AE.UTF-8";
      LC_TELEPHONE = "ar_AE.UTF-8";
      LC_TIME = "ar_AE.UTF-8";
    };

    services.upower.enable = true;

    hardware = {
      enableAllFirmware = true;

      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };

    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "gameoflife";
      };
    };

    programs.gamescope.enable = true;

    programs.steam = {
      enable = true; # Master switch, already covered in installation
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    };

    # zen browser
    environment.systemPackages = [
      zen
    ];
  };
}
