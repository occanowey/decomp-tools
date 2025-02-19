{
  fetchFromGitHub,
  python3Packages,
  libyaml,
}:
with python3Packages;
  buildPythonPackage rec {
    pname = "pylibyaml";
    version = "597e785";

    src = fetchFromGitHub {
      owner = "philsphicas";
      repo = "pylibyaml";
      rev = "${version}";
      sha256 = "sha256-QbUyBStzOw9nl56v0E2XYFH7xQWi5VTluvPx4nO8Mfc=";
    };

    buildInputs = [libyaml];
  }
