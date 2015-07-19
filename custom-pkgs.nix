{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);

  self = {
    assorted-scripts = callPackage ./pkgs/assorted-scripts { };

    udp-cat-debug = callPackage ./pkgs/udp-cat { debug = true; };
    udp-cat       = callPackage ./pkgs/udp-cat { debug = false; };

    java-ggp-base = callPackage ./pkgs/java-ggp-base { };
    java-guava    = callPackage ./pkgs/java-guava { };

    findbugs-jsr305-jar = callPackage ./pkgs/hacks/jars/findbugs-jsr305 { };
    inject-jsr330-jar   = callPackage ./pkgs/hacks/jars/inject-jsr330 { };
  };
in
self
