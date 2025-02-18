# { rpRef ? "384cd850f3adf1d404bced2424b5f6efb0f415f2"
# , rpSha ? "1ws77prqx8khmp8j6br1ij4k2v4dlgv170r9fmg0p1jivfbn8y9d"
# }:
{ rpRef ? "a15d3a2411e7ca7d4ee4853b57c72fe83faee272"
, rpSha ? "1dsvw0lah7761vndip1hqal4fjpjv84ravinnfhy83jgfav5ivna"
}:

let rp = builtins.fetchTarball {
  url = "https://github.com/reflex-frp/reflex-platform/archive/${rpRef}.tar.gz";
  sha256 = rpSha;
};

in
  (import rp {}).project ({ pkgs, ... }:
  let gitignore = pkgs.callPackage (pkgs.fetchFromGitHub {
        owner = "siers";
        repo = "nix-gitignore";
        rev = "4f2d85f2f1aa4c6bff2d9fcfd3caad443f35476e";
        sha256 = "1vzfi3i3fpl8wqs1yq95jzdi6cpaby80n8xwnwa8h2jvcw3j7kdz";
      }) {};
  in
  {
    name = "reflex-dom-contrib";
    overrides = self: super: with pkgs.haskell.lib;
       {
       };
    packages = {
      reflex-dom-contrib = gitignore.gitignoreSource [] ./.;
    };
    shellToolOverrides = ghc: super: {
      ghcid = pkgs.haskellPackages.ghcid;
    };
    shells = {
      ghc = ["reflex-dom-contrib"];
      ghcjs = ["reflex-dom-contrib"];
    };

  })
