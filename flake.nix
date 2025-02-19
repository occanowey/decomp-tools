{
  description = "decomp tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in rec {
    formatter.${system} = pkgs.alejandra;

    packages.${system} = {
      splat = pkgs.callPackage ./nix/pkgs/splat.nix {};
      m2c = pkgs.callPackage ./nix/pkgs/m2c.nix {};
      m2ctx = pkgs.callPackage ./nix/pkgs/m2ctx {};

      objdiffWayland = pkgs.callPackage ./nix/pkgs/objdiff.nix {enableWayland = true;};
      objdiffX11 = pkgs.callPackage ./nix/pkgs/objdiff.nix {enableX11 = true;};
    };
  };
}
