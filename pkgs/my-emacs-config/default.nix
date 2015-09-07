{ stdenv, writeTextFile, user, fullUserName, extraConfig, colorThemeSolarized,
  erlangMode, haskellMode, tuaregMode, merlin, ocpIndent, utop }:

stdenv.mkDerivation rec {

  name = "emacs-config";

  static-config = ./static.el;

  base-config = writeTextFile {
    name = "emacs-config-base.el";
    text = ''
      ;; Color Theme Path
      (add-to-list 'custom-theme-load-path "${colorThemeSolarized}/share/emacs/site-lisp")

      ;; User specific info
      (setq user-full-name "${fullUserName}")

      ;; Modes
      (add-to-list 'load-path "${erlangMode}/share/emacs/site-lisp")
      (require 'erlang-start)

      (add-to-list 'load-path "${haskellMode}/share/emacs/site-lisp")
      (require 'haskell-mode)

      (add-to-list 'load-path "${merlin}/share/emacs/site-lisp")
      (add-to-list 'load-path "${ocpIndent}/share/emacs/site-lisp")
      (load "${tuaregMode}/share/emacs/site-lisp/tuareg-site-file")
      (require 'merlin)
      (require 'ocp-indent)
      (setq merlin-command "${merlin}/bin/ocamlmerlin")
      (setq ocp-indent-path "${ocpIndent}/bin/ocp-indent")
      (setq utop-command "${utop}/bin/utop -emacs")

      ;; Nix profile (we shouldn't need this once everything is nixed)
      (add-to-list 'load-path "/home/${user}/.nix-profile/share/emacs/site-lisp")

      ;; Load the static configuration
      (load "${static-config}")

      ;; Extra config added by the extraConfig parameter of the  derivation
      ${extraConfig}
    '';
  };

  buildCommand = ''
    DIR=$out/etc/${user}-config
    mkdir $DIR -p
    ln -s ${base-config} $DIR/emacs.el
  '';
}
