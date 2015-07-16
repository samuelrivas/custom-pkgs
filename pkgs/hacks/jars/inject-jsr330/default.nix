{ stdenv, fetchurl, unzip }:

stdenv.mkDerivation rec {
  version = "1";
  name = "inject-jsr330-jar-${version}";

  src = fetchurl {
    url = http://atinject.googlecode.com/files/javax.inject.zip;
    sha256 = "0v1nkv07pcxj6467div3dvfsnb1ggxj3h93f5rvdvx1dn1fzavy6";
  };

  buildInputs = [ unzip ];

  setSourceRoot = "sourceRoot=$(pwd)";
  installPhase = ''
      mkdir -p $out/share/java
      cp  javax.inject.jar $out/share/java/
  '';

  dontBuild = true;

  meta = {
    description = "Quick package for Google's inject JSR while we don't have one from source";
    homepage = http://code.google.com/p/atinject/;
    license = stdenv.lib.licenses.asl20;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
