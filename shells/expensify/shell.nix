let
  pkgs = import <nixpkgs> { };
  buildNodejs = pkgs.callPackage <nixpkgs/pkgs/development/web/nodejs/nodejs.nix> {
    icu = pkgs.icu68;
    python = pkgs.python39;
  };

  nodejs-16 = buildNodejs {
    enableNpm = true; # We need npm, do we?
    version = "16.15.1";
    sha256 = "1OmdPB9pcREJpnUlVxBY5gCc3bwijn1yO4+0pFQWm30=";
    # copied these patches from here: https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/web/nodejs/v16.nix
    patches = [
      ./disable-darwin-v8-system-instrumentation.patch
      ./bypass-darwin-xcrun-node16.patch
      # ./node-npm-build-npm-package-logic-node16.patch
    ];
  };

in
pkgs.mkShell
rec {
  shellHook = ''
    export NODE_OPTIONS=""

  '';


  name = "webdev";
  buildInputs = with pkgs; [
    bundler
    nodejs-16
    nodePackages.node-gyp
    (yarn.override { nodejs = nodejs-16; })
  ];
}

