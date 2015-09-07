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

    erlang-mode = callPackage ./pkgs/erlang-mode { };

    # TODO:
    #
    #  * Make sure we have no extra config
    #    * create erlang-mode
    #  * Use the modes by their link, instead of feching them from the profile
    #  * Read the config for this from a file a-la configuration.nix
    samuel-emacs-config = callPackage ./pkgs/my-emacs-config {
      user = "samuel";
      full-user-name = "Samuel Rivas";
      extra-config = ''
        ;; workarounds
        (require 'iso-transl) ; required for dead keys to work with ibus
      '';
    };
  };
in
self
