{
  nixpkgs ? (builtins.fetchGit {
    name = "nixos-stable-20.09";
    url = "https://github.com/nixos/nixpkgs";
    ref = "refs/tags/20.09";
  })
}:

with import nixpkgs {};
gcc49Stdenv.mkDerivation {
  name = "llvm-2.9";

  src = ./src;
  # src = builtins.fetchTarball {
  #   name = "llvm-2.9";
  #   url = https://releases.llvm.org/2.9/llvm-2.9.tgz;
  #   sha256 = "1wrsbcnbpzcmids2pn19z6nw7384y3k0ivp9qdx0mlb312hn0gcm";
  # };

  buildInputs = [
    perl
    groff
    # Would be better to use gcc 4.5, see https://gcc.gnu.org/releases.html
    gcc48
  ];

  shellHook = ''
    echo "LLVM 2.9 - a blast from the past!"
  '';
}
