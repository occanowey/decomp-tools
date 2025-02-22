# https://github.com/simonlindholm/asm-differ
{
  callPackage,
  fetchFromGitHub,
  python3Packages,
  fetchPypi,
}:
with python3Packages; let
  # https://github.com/NixOS/nixpkgs/blob/73cf49b8ad837ade2de76f87eb53fc85ed5d4680/pkgs/development/python-modules/watchdog/default.nix
  oldWatchdog = watchdog.overrideAttrs (final: prev: rec {
    version = "4.0.2";

    src = fetchPypi {
      pname = prev.pname;
      inherit version;
      hash = "sha256-tN+7bEkiG+RTViPqRHSk1u4KnO9KgLIMKNtNhYtk4nA=";
    };
  });

  oldLevenshtein = callPackage ../python_pkgs/levenshtein.nix {};
in
  buildPythonApplication rec {
    pname = "asm-differ";
    version = "f24945c";

    src = fetchFromGitHub {
      owner = "simonlindholm";
      repo = "asm-differ";
      rev = "${version}";
      sha256 = "sha256-jDp3aW7Q8JypCVWLMNmHiWC0YsisWQSNMgR/YoYfn20=";
    };

    # format = "pyproject";
    # nativeBuildInputs = [poetry-core];

    propagatedBuildInputs = [colorama oldWatchdog oldLevenshtein cxxfilt];

    # asm-differ's pyproject.toml seems like it's only used to install deps
    # and is kinda busted as an actual project, so just install manually
    #
    # fixed in: https://github.com/simonlindholm/asm-differ/pull/157
    format = "other";
    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/asm-differ
      mv * $out/share/asm-differ

      makeWrapper ${python.interpreter} $out/bin/asm-differ \
        --set PYTHONPATH "$PYTHONPATH:$out/share/asm-differ" \
        --add-flags "-O $out/share/asm-differ/diff.py"

      runHook postInstall
    '';
  }
