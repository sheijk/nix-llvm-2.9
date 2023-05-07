{
  description = "LLVM 2.9 providing the old JIT";

  nixConfig.extra-experimental-features = "nix-command flakes";

  inputs = {
    nixpkgs.url   = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {inherit system; overlays = [];}; in
      {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "llvm-2.9";

          src = ./src;
          # src = builtins.fetchTarball {
          #   name = "llvm-2.9";
          #   url = https://releases.llvm.org/2.9/llvm-2.9.tgz;
          #   sha256 = "1wrsbcnbpzcmids2pn19z6nw7384y3k0ivp9qdx0mlb312hn0gcm";
          # };

          buildInputs = (with pkgs; [
            perl
            groff
            # Would be better to use gcc 4.5, see https://gcc.gnu.org/releases.html
            gcc48
          ]);

          shellHook = ''
            echo "LLVM 2.9 - a blast from the past!"
          '';
        };
      });
}

