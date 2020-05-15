{ pkgs ? import ./nixpkgs.nix {} }:

with pkgs;

let
  inherit (rust.packages.nightly) rustPlatform;
in

{
  myrustlib = buildRustPackage rustPlatform {
    name = "myrustlib";
    src = ./pyext-myrustlib;
    buildInputs = [ python3 ];
    cargoDir = ".";
  };
}
