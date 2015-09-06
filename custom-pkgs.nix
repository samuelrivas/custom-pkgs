{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs
                                       // pkgs.xlibs
                                       // pkgs.gnome3
                                       // self);

  self = rec {
    assorted-scripts = callPackage ./pkgs/assorted-scripts { };

    udp-cat-debug = callPackage ./pkgs/udp-cat { debug = true; };
    udp-cat       = callPackage ./pkgs/udp-cat { debug = false; };

    colorhug-client =
      callPackage ./pkgs/colorhug-client { automake = pkgs.automake115x; };

    colord = callPackage ./pkgs/colord { automake = pkgs.automake115x; };
    colord-gtk = pkgs.colord-gtk.override { inherit colord; };

    jam       = callPackage ./pkgs/jam { };
    argyllcms = callPackage ./pkgs/argyllcms { };
  };
in
self
