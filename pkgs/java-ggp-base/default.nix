{ stdenv, fetchFromGitHub, gradle }:

stdenv.mkDerivation {
  name = "java-ggp-base-0.0.0";

  src = fetchFromGitHub {
    owner = "ggp-org";
    repo = "ggp-base";
    rev = "8e415e6190159f03e48ad3d991bf33963440f4c9";
    sha256 = "1mb5mfdwmxwsqlaj3p5mrzbyscx9dany36j4clhhcgz2cnnnhim9";
  };

  buildInputs = [ gradle ];

  buildPhase = "${gradle}/bin/gradle jar";

  installPhase = ''
      mkdir -p "$out/share/java"
      cp build/libs/ggp-base*.jar "$out/share/java/ggp-base.jar"
  '';

  meta = {
    description = "Application Suite for the General Game Playing Project";
    homepage = https://github.com/ggp-org/ggp-base;
    license = stdenv.lib.licenses.bsd3;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
