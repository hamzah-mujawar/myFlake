{
  flake.nixosModules.vpn = {pkgs, ...}: {
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
  };
}
