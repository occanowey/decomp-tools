{
  description = "decomp";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    decomp-tools = {
      url = "github:";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    decomp-tools,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    formatter.${system} = pkgs.alejandra;

    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with decomp-tools.packages.${system}; [
        splat
        m2c
        m2ctx
        objdiffWayland
      ];
    };
  };
}
