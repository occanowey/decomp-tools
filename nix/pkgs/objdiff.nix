# https://github.com/encounter/objdiff
{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  fontconfig,
  makeWrapper,
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

  nativeBuildInputs = [pkg-config makeWrapper];
  buildInputs = [fontconfig];

  postFixup = let
    libPath = lib.makeLibraryPath (
      [libxkbcommon libGL]
      ++ lib.optionals enableWayland [wayland]
      ++ (with xorg; lib.optionals enableX11 [libXcursor libXext libXrandr libXi])
    );
  in ''
    wrapProgram $out/bin/objdiff \
      --prefix LD_LIBRARY_PATH : "${libPath}"
  '';
}
