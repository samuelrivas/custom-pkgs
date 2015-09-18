{
  autoconf,
  automake,
  bashCompletion,
  fetchzip,
  glib,
  gobjectIntrospection,
  intltool,
  pkgconfig,
  polkit,
  python,
  sqlite,
  stdenv,
  systemd
}:

let
  version = "0.9.5";
in
stdenv.mkDerivation rec {
  name = "packagekit-${version}";

  src = fetchzip {
    url = "http://www.freedesktop.org/software/PackageKit/releases/PackageKit-${version}.tar.xz";
    sha256 = "03qf889rlm23nwwryspsxsphm2lsrbjrlkfp70zbnr0fnlss6s7s";
  };

  buildInputs = [
    autoconf
    automake
    bashCompletion
    glib
    gobjectIntrospection
    intltool
    pkgconfig
    polkit
    python
    sqlite
    systemd
  ];

  configureFlags = "--with-systemdsystemunitdir=$(out)/craptorelocate --disable-bash-completion";

  meta = {
    description = "A DBUS packaging abstraction layer";
    longDescription = "PackageKit is a DBUS abstraction layer that allows the
      session user to manage packages in a secure way using a cross-distro,
      cross-architecture API.";
    homepage = http://www.freedesktop.org/software/PackageKit/;
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
