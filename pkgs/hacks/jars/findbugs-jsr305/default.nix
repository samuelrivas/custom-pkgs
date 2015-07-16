{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  version = "1.3.7";
  name = "findbugs-jsr305-jar-${version}";

  src = fetchurl {
    url = http://mirrors.ibiblio.org/pub/mirrors/maven2/com/google/code/findbugs/jsr305/1.3.7/jsr305-1.3.7.jar;
    sha256 = "0s74pv8qjc42c7q8nbc0c3b1hgx0bmk3b8vbk1z80p4bbgx56zqy";
  };

  buildInputs = [ ];

  unpackPhase = "cp $src .";
  installPhase = ''
      mkdir -p $out/share/java
      cp  $src $out/share/java/jsr305-1.3.7.jar
  '';

  dontBuild = true;

  meta = {
    description = "Quick pacakge for findbug's jsr while we don't have a proper package";
    homepage = http://findbugs.sourceforge.net/;
    license = stdenv.lib.licenses.lgpl3Plus;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
