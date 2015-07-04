{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);

  self = {
    assorted-scripts = callPackage ./pkgs/assorted-scripts { };
  };
in
self
