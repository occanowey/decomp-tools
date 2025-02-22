# https://github.com/NixOS/nixpkgs/blob/63d05d989e73c5a59bb1c4fd3b32e5e40136528d/pkgs/development/python-modules/levenshtein/default.nix
{
  lib,
  python3Packages,
  cmake,
  fetchFromGitHub,
  rapidfuzz-cpp,
}:
python3Packages.buildPythonPackage rec {
  pname = "levenshtein";
  version = "0.25.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "maxbachmann";
    repo = "Levenshtein";
    rev = "refs/tags/v${version}";
    hash = "sha256-ye2XQL/ZQPlA4dy3tlr03WyGhfl7SaOXMt10cWHnW5o=";
    fetchSubmodules = true; # # for vendored `rapidfuzz-cpp`
  };

  nativeBuildInputs = [
    cmake
    python3Packages.cython
    python3Packages.scikit-build
  ];

  dontUseCmakeConfigure = true;

  buildInputs = [rapidfuzz-cpp];

  dependencies = [python3Packages.rapidfuzz];

  nativeCheckInputs = [python3Packages.pytestCheckHook];

  pythonImportsCheck = ["Levenshtein"];

  meta = with lib; {
    description = "Functions for fast computation of Levenshtein distance and string similarity";
    homepage = "https://github.com/maxbachmann/Levenshtein";
    changelog = "https://github.com/maxbachmann/Levenshtein/blob/${src.rev}/HISTORY.md";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [fab];
  };
}
