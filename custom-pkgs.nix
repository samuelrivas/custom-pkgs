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

    erlangMode = callPackage ./pkgs/erlang-mode { };

    tuaregMode = callPackage ./pkgs/tuareg { };

    # TODO:
    #
    #  * Make sure we have no extra config
    #    * create erlang-mode
    #  * Use the modes by their link, instead of feching them from the profile
    #  * Read the config for this from a file a-la configuration.nix
    samuelEmacsConfig = callPackage ./pkgs/my-emacs-config {
      inherit (pkgs.emacsPackages) haskellMode;
      inherit (pkgs.ocamlPackages) ocpIndent; # Currently broken for 4.02.1
      inherit (pkgs.ocamlPackages_4_02_1) merlin utop;
      user = "samuel";
      fullUserName = "Samuel Rivas";
      extraConfig = ''
        ;; workarounds
        (require 'iso-transl) ; required for dead keys to work with ibus
      '';
    };
  };
in
self
