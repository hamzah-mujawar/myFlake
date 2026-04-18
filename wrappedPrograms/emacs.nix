{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.emacs = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.custom-emacs];
    services.emacs.enable = true;
    services.emacs.package = self.packages.${pkgs.stdenv.hostPlatform.system}.custom-emacs;
  };

  perSystem = {pkgs, ...}: let
    newpkgs =
      pkgs.appendOverlays
      (with inputs.emacs-overlay.overlays; [
        emacs
        package
      ]);

    tree-sitter-parsers = grammars:
      with grammars; [
        tree-sitter-bash
        tree-sitter-c
        tree-sitter-c-sharp
        tree-sitter-cmake
        tree-sitter-cpp
        tree-sitter-css
        tree-sitter-dot
        tree-sitter-elisp
        tree-sitter-glsl
        tree-sitter-haskell
        tree-sitter-html
        tree-sitter-java
        tree-sitter-javascript
        tree-sitter-json
        tree-sitter-json5
        tree-sitter-kotlin
        tree-sitter-latex
        tree-sitter-llvm
        tree-sitter-lua
        tree-sitter-make
        tree-sitter-markdown
        tree-sitter-markdown-inline
        tree-sitter-nickel
        tree-sitter-nix
        tree-sitter-prisma
        tree-sitter-python
        tree-sitter-regex
        tree-sitter-rust
        tree-sitter-scss
        tree-sitter-sql
        tree-sitter-toml
        tree-sitter-tsx
        tree-sitter-typescript
        tree-sitter-vim
        tree-sitter-yaml
        tree-sitter-zig
      ];

    custom-emacs = with newpkgs; ((emacsPackagesFor (emacs30-pgtk.override {withNativeCompilation = true;})).emacsWithPackages (epkgs:
      with epkgs; [
        jinx
        vterm
        (treesit-grammars.with-grammars (grammars: tree-sitter-parsers grammars))
      ]));
  in {
    packages = {
      inherit custom-emacs;
    };
  };
}
