{
  description = "decomp tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    overlay = self: super: {
      splat = self.callPackage ./nix/pkgs/splat.nix {};
      m2c = self.callPackage ./nix/pkgs/m2c.nix {};
      m2ctx = self.callPackage ./nix/pkgs/m2ctx {};

      objdiffWayland = self.callPackage ./nix/pkgs/objdiff.nix {enableWayland = true;};
      objdiffX11 = self.callPackage ./nix/pkgs/objdiff.nix {enableX11 = true;};
    };

    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [overlay];
    };
  in {
    formatter.${system} = pkgs.alejandra;

    packages.${system} = with pkgs; {inherit splat m2c m2ctx objdiffWayland objdiffX11;};

    overlays.default = overlay;

    templates.full = {
      path = ./template;
      description = "a nix devshell & devenv containing all default tools";
    };
  };
}
