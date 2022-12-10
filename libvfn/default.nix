{ stdenv
, fetchFromGitHub
, pkg-config
, meson
, ninja
, perl
}:

stdenv.mkDerivation rec {
  pname = "libvfn";
  version = "0.0.99";

  src = fetchFromGitHub {
    owner = "OpenMPDK";
    repo = "libvfn";
    rev = "e2603fcc024aeccfc7feef7e4a403fd9dac29bb3";
    hash = "sha256-CwhtrxKRo0L7CjEVM9uBY0/cxunaCKLlHvZtI/5eECE=";
  };

  patches = [
    ./trace_pl_pathfix.patch
  ];

  mesonFlags = [
    "-Ddocs=disabled"
    "-Dlibnvme=disabled"
    "-Dprofiling=false"
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    perl
  ];
}
