{ pkgs ? import ./nixpkgs.nix {} }:

with pkgs;

mkShell {
  inputsFrom = lib.attrValues (import ./. { inherit pkgs; });
  RUST_MIN_STACK = 8388608;
  buildInputs = [ pkgs.python3Packages.pytest pkgs.python3Packages.pytest-benchmark ];
  shellHook = ''
  	export PYTHONPATH="$(pwd)/result/lib:$PYTHONPATH"
  '';	
}
