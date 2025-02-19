{
  fetchFromGitHub,
  python3Packages,
}:
with python3Packages;
  buildPythonPackage rec {
    pname = "n64img";
    version = "0.3.3";

    src = fetchFromGitHub {
      owner = "decompals";
      repo = "n64img";
      rev = "${version}";
      sha256 = "sha256-3nI+Bu7Slw4My0V1ZsLOFEtxL/ojF60UwJpm1Lwv02o=";
    };

    format = "pyproject";

    nativeBuildInputs = [setuptools];
    propagatedBuildInputs = [pypng];
  }
