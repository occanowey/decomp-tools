# https://github.com/ethteck/splat
{
  callPackage,
  fetchFromGitHub,
  python3Packages,
}: let
  pylibyaml = callPackage ../python_pkgs/pylibyaml.nix {};
  spimdisasm = callPackage ../python_pkgs/spimdisasm.nix {};
  rabbitizer = callPackage ../python_pkgs/rabbitizer.nix {};
  pygfxd = callPackage ../python_pkgs/pygfxd.nix {};
  n64img = callPackage ../python_pkgs/n64img.nix {};
  crunch64 = callPackage ../python_pkgs/crunch64.nix {};
in
  with python3Packages;
    buildPythonApplication rec {
      pname = "splat";
      version = "0.32.3";

      src = fetchFromGitHub {
        owner = "ethteck";
        repo = "splat";
        rev = "${version}";
        sha256 = "sha256-R4psuO/fyk1ujHnekruRMiVCyww5r7KnPF8nhDuv8iU=";
      };

      format = "pyproject";

      nativeBuildInputs = [hatchling];

      optional-dependencies = {
        mips = [spimdisasm rabbitizer pygfxd n64img crunch64];
      };

      propagatedBuildInputs = [colorama intervaltree pylibyaml pyyaml tqdm] ++ optional-dependencies.mips;
    }
