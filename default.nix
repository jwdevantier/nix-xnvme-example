{ pkgs ? import <nixpkgs> {} }:
rec {
  libvfn = pkgs.callPackage ./libvfn {};
  xnvme = pkgs.callPackage ./xnvme { inherit libvfn; };
}
