# https://github.com/encounter/objdiff
{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  autoPatchelfHook,
  fontconfig,
  libxkbcommon,
  libGL,
  enableWayland ? false,
  wayland,
  enableX11 ? false,
  xorg,
}:
rustPlatform.buildRustPackage rec {
  pname = "objdiff";
  version = "v2.7.1";

  src = fetchFromGitHub {
    owner = "encounter";
    repo = "objdiff";
    rev = "${version}";
    sha256 = "sha256-KnWStN8X1GmuBs0sUVqiR2To72N8XYNvPJPNvIYQUv4=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-AGtVOhmldzBKUCxDETWjjyDcYS/cZUokJEpbpllpVdQ=";

  nativeBuildInputs = [pkg-config autoPatchelfHook];
  buildInputs = [fontconfig];

  fixupPhase = let
    libPath = lib.makeLibraryPath (
      [libxkbcommon libGL]
      ++ (lib.optionals enableWayland [wayland])
      ++ (with xorg; lib.optionals enableX11 [libXcursor libXext libXrandr libXi])
    );
  in ''
    patchelf --add-rpath "${libPath}" $out/bin/objdiff
  '';
}
