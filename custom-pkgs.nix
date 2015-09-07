{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);

  self = {
    assorted-scripts = callPackage ./pkgs/assorted-scripts { };

    udp-cat-debug = callPackage ./pkgs/udp-cat { debug = true; };
    udp-cat       = callPackage ./pkgs/udp-cat { debug = false; };

    jam       = callPackage ./pkgs/jam { };
    argyllcms = callPackage ./pkgs/argyllcms { };

    colorThemeSolarized = callPackage ./pkgs/color-theme-solarized {
      inherit (pkgs.emacsPackages) colorTheme;
    };
  };
in
self
