{
  fetchFromGitHub,
  python3Packages,
}:
with python3Packages;
  buildPythonPackage rec {
    pname = "rabbitizer";
    version = "1.12.5";

    src = fetchFromGitHub {
      owner = "Decompollaborate";
      repo = "rabbitizer";
      rev = "${version}";
      sha256 = "sha256-tWtsYoeSXo4XuG0aShNyIvOgQDcPWKHRbVGOVcq2Xwo=";
    };

    format = "pyproject";

    nativeBuildInputs = [setuptools];
  }
