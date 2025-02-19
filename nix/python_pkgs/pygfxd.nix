{
  fetchFromGitHub,
  python3Packages,
}:
with python3Packages;
  buildPythonPackage rec {
    pname = "pygfxd";
    version = "v1.0.3";

    src = fetchFromGitHub {
      owner = "Thar0";
      repo = "pygfxd";
      rev = "${version}";
      sha256 = "sha256-V5GxPiOsl5X5q5c1gpyty6EPKrEapGmxIFZEGH3MqQw=";
    };
  }
