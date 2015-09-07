{ stdenv, writeTextFile, user, colorThemeSolarized }:

stdenv.mkDerivation rec {

  name = "emacs-config";

  static-config = ./static.el;

  base-config = writeTextFile {
    name = "emacs-config-base.el";
    text = ''
      ;; Color Theme Path
      (add-to-list 'custom-theme-load-path "${colorThemeSolarized}/share/emacs/site-lisp")
      (load "${static-config}")
    '';
  };

  buildCommand = ''
    DIR=$out/etc/${user}-config
    mkdir $DIR -p
    ln -s ${base-config} $DIR/emacs.el
  '';
}
