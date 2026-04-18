{
  lib,
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    # My primary flake shell with all of it's packages
    packages.environment = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.fish;
      runtimeInputs = [
        # nix
        pkgs.nil
        pkgs.nixd
        pkgs.statix
        pkgs.alejandra
        pkgs.manix
        pkgs.nix-inspect
        self'.packages.nh

        # other
        pkgs.unzip
        pkgs.zip
        pkgs.wget
        pkgs.fzf
        pkgs.bottom
        pkgs.fd
        pkgs.zoxide
        pkgs.ripgrep
        pkgs.fastfetch
        pkgs.wl-clipboard
        pkgs.gdb

        #wrapped
        self'.packages.git
        self'.packages.bat
      ];
    };
  };
}
