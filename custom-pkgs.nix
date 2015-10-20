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

    # Waiiting for the fix to make it to the channels. Merged the 2015-09-07 in
    # b70ffedbccc9ae2595e7cb1bbde66fbde5db8051
    colorThemeSolarized = callPackage ./pkgs/color-theme-solarized {
      inherit (pkgs.emacs24Packages) colorTheme;
    };

    # Waiting for it to make to the channes, merged the 2015-09-07 in
    # 54bcc4e44670dea71f8df2a1833744f1efc98190
    erlangMode = callPackage ./pkgs/erlang-mode { };

    # TODO:
    #  * Read the config for this from a file a-la configuration.nix
    samuelEmacsConfig = callPackage ./pkgs/my-emacs-config {
      inherit (pkgs.emacs24Packages) haskellMode tuaregMode;
      inherit (pkgs.ocamlPackages_4_02_1) merlin ocpIndent utop;

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
