{
  callPackage,
  fetchFromGitHub,
  python3Packages,
}: let
  rabbitizer = callPackage ./rabbitizer.nix {};
in
  with python3Packages;
    buildPythonPackage rec {
      pname = "spimdisasm";
      version = "1.32.0";

      src = fetchFromGitHub {
        owner = "Decompollaborate";
        repo = "spimdisasm";
        rev = "${version}";
        sha256 = "sha256-0HaRYHqA+k5MhEdd0hcRUi+umO3OJ+WKGWqXnAJCME8=";
      };

      format = "pyproject";

      nativeBuildInputs = [setuptools];
      propagatedBuildInputs = [rabbitizer];
    }
