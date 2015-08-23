# Broken:
#
# Yelp tools need to be added in, otherwise compilation fails (not checked by
# config)
#
# passing docbook2x as buildinput triggers man page generation, but that fails
{ stdenv, fetchzip, itstool, gusb, pkgconfig, intltool, glib, libxml2, libusb,
  gtk3, colord, colord-gtk, libsoup, bashCompletion, automake, autoconf,
  docbook2x, yelp_tools}:

let
  version = "0.2.7";
  package-name = "colorhug-client";
in
stdenv.mkDerivation rec {
  name = "${package-name}-${version}";

  src = fetchzip {
    url = "http://people.freedesktop.org/~hughsient/releases/colorhug-client-${version}.tar.xz";
    sha256 = "054fikivwscai9fyi3w1783vw7gswp318fvmylq2cqdg9nfgpghr";
  };

  buildInputs = [ itstool gusb pkgconfig intltool glib libxml2 libusb gtk3
                  colord colord-gtk libsoup bashCompletion automake autoconf
                  yelp_tools ];

  meta = {
    description = "Client tools for the colorhug colorimeter";
    homepage = http://www.hughski.com/;
    license = stdenv.lib.licenses.gpl1;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}

