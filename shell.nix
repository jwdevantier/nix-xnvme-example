{ pkgs ? import <nixpkgs> {} }:
let
  def = import ./default.nix { pkgs = pkgs; };
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.gcc
      pkgs.pkg-config
      pkgs.libuuid
      pkgs.libtool
      pkgs.nasm
      pkgs.liburing
      pkgs.libaio
      def.xnvme
      def.libvfn
    ];
  }
