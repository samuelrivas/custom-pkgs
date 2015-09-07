{ stdenv, writeTextFile, user, full-user-name, extra-config,
  colorThemeSolarized, erlang-mode }:

stdenv.mkDerivation rec {

  name = "emacs-config";

  static-config = ./static.el;

  base-config = writeTextFile {
    name = "emacs-config-base.el";
    text = ''
      ;; Color Theme Path
      (add-to-list 'custom-theme-load-path "${colorThemeSolarized}/share/emacs/site-lisp")

      ;; User specific info
      (setq user-full-name "${full-user-name}")

      ;; Modes
      (add-to-list 'load-path "${erlang-mode}/share/emacs/site-lisp")
      (require 'erlang-start)


      ;; Nix profile (we shouldn't need this once everything is nixed)
      (add-to-list 'load-path "/home/${user}/.nix-profile/share/emacs/site-lisp")

      ;; Load the static configuration
      (load "${static-config}")

      ;; Extra config added by ${name} derivation
      ${extra-config}
    '';
  };

  buildCommand = ''
    DIR=$out/etc/${user}-config
    mkdir $DIR -p
    ln -s ${base-config} $DIR/emacs.el
  '';
}
