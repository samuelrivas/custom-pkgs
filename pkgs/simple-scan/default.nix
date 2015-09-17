{
  cairo,
  fetchzip,
  glib,
  gtk3,
  gusb,
  libusb,
  pkgconfig,
  stdenv,
  vala
}:

let
  version = "3.17.92";
in
stdenv.mkDerivation rec {
  name = "simple-scan-${version}";

  src = fetchzip {
    url = "https://launchpad.net/simple-scan/3.17/${version}/+download/simple-scan-${version}.tar.xz";
    sha256 = "0rcwyx8vpw03qlysvb4qizfjj4qayz2nfslmnz9h9asm1p5cdja0";
  };

  buildInputs = [ cairo glib gtk3 gusb libusb pkgconfig vala ];

  meta = {
    description = "Simple Scanning Utility";
    longDescription = "Simple Scan is an easy-to-use application, designed to
      let users connect their scanner and quickly have the image/document in an
      appropriate format.  Simple Scan is basically a frontend for SANE - which
      is the same backend as XSANE uses. This means that all existing scanners
      will work and the interface is well tested.";
    homepage = https://launchpad.net/simple-scan;
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
