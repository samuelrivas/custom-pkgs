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
      inherit (pkgs.emacs24Packages) colorTheme;
    };

    erlangMode = callPackage ./pkgs/erlang-mode { };

    tuaregMode = callPackage ./pkgs/tuareg { };

    ocpBuild = callPackage ./pkgs/ocp-build {
      inherit (pkgs.ocamlPackages_4_02_1) findlib camlp4;
    };

    # TODO:
    #  * Read the config for this from a file a-la configuration.nix
    samuelEmacsConfig = callPackage ./pkgs/my-emacs-config {
      inherit (pkgs.emacs24Packages) haskellMode;
      inherit (pkgs.ocamlPackages_4_02_1) merlin;

      # Currently broken for 4.02.1
      ocpIndent = pkgs.ocamlPackages.ocpIndent.override {
        ocpBuild = self.ocpBuild;
        opam = self.opam;
        cmdliner = self.cmdliner;
      };
      utop = self.utop;
      user = "samuel";
      fullUserName = "Samuel Rivas";
      extraConfig = ''
        ;; workarounds
        (require 'iso-transl) ; required for dead keys to work with ibus
      '';
    };

    ## Overrides to overcome some broken packages in the current HEAD
    ## There must be a better way of doing this, the offender is just opam and
    ## ocp-build
    opam = pkgs.opam_1_1;

    utop = pkgs.ocamlPackages.utop.override {
      ocaml_react = self.ocaml_react;
      zed = self.zed;
      ocaml_lwt = self.ocaml_lwt;
      lambdaTerm = self.lambdaTerm;
    };

    ocaml_react = pkgs.ocamlPackages.ocaml_react.override {
      opam = self.opam;
    };

    zed = pkgs.ocamlPackages.zed.override {
      ocaml_react = self.ocaml_react;
    };

    ocaml_lwt = pkgs.ocamlPackages.ocaml_lwt.override {
      ocaml_react = self.ocaml_react;
    };

    lambdaTerm = pkgs.ocamlPackages.lambdaTerm.override {
      ocaml_lwt = self.ocaml_lwt;
      ocaml_react = self.ocaml_react;
      zed = self.zed;
    };

    cmdliner = pkgs.ocamlPackages.cmdliner.override {
      opam = self.opam;
    };

  };
in
self
