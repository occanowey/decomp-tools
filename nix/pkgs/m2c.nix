# https://github.com/matt-kempster/m2c/
{
  fetchFromGitHub,
  python3Packages,
}:
with python3Packages;
  buildPythonApplication rec {
    pname = "m2c";
    version = "7b85327";

    src = fetchFromGitHub {
      owner = "matt-kempster";
      repo = "m2c";
      rev = "${version}";
      sha256 = "sha256-Y+hEL+MKOPDNoSmWLJrCI+IUc4551I0uqT5zETaUIn8=";
    };

    format = "pyproject";

    nativeBuildInputs = [poetry-core];
    propagatedBuildInputs = [pycparser graphviz];
  }
