{ stdenv, writeTextFile, user, colorThemeSolarized }:

stdenv.mkDerivation rec {

  name = "${user}-emacs-config";

  emacs = writeTextFile {
    name = "${user}-emacs.el";
    text = ''
      ;; Color Theme
      (add-to-list 'custom-theme-load-path "${colorThemeSolarized}/share/emacs/site-lisp")
      (setq frame-background-mode 'dark)
      (load-theme 'solarized t)
      (enable-theme 'solarized)
    '';
  };

  buildCommand = ''
    DIR=$out/etc/${user}-config
    mkdir $DIR -p
    ln -s ${emacs} $DIR/emacs.el
  '';
}
