{
  fetchFromGitHub,
  python3Packages,
  rustPlatform,
}:
with python3Packages;
  buildPythonPackage rec {
    pname = "crunch64";
    version = "0.5.3";

    src = fetchFromGitHub {
      owner = "decompals";
      repo = "crunch64";
      rev = "${version}";
      sha256 = "sha256-Kuid2u5HzHfyeDOYlh18P/DKIbNr79zdpZlgQ560N4s=";
    };

    buildAndTestSubdir = "lib";
    format = "pyproject";

    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit pname version src;
      hash = "sha256-XO9nWhR1hDcx7t9ib6gHI1jSyvNbAUPzTlXQP8Ub7kw=";
    };

    nativeBuildInputs = with rustPlatform; [maturinBuildHook cargoSetupHook];
  }
