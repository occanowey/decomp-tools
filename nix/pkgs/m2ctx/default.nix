# https://github.com/ethteck/m2ctx
{
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "m2ctx";
  version = "1eace1c";

  src = fetchFromGitHub {
    owner = "ethteck";
    repo = "m2ctx";
    rev = "${version}";
    sha256 = "sha256-3m75OPsijZV2DefmYkcUzmiqxNMzVancKKx8fNiN0eY=";
  };

  format = "other";

  patches = [./rel_wd.patch];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp m2ctx.py $out/bin/m2ctx

    runHook postInstall
  '';

  checkPhase = ''
    runHook preCheck

    PYTHONPATH="" $out/bin/m2ctx -h > /dev/null

    runHook postCheck
  '';
}
