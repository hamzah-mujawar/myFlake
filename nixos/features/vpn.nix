{
  flake.nixosModules.vpn = {pkgs, ...}: {
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
  };
}
