{ stdenv, fetchFromGitHub, jdk, findbugs-jsr305-jar, inject-jsr330-jar }:

stdenv.mkDerivation rec {
  version = "14.0.1";
  name = "java-guava-${version}";

  src = fetchFromGitHub {
    owner = "google";
    repo = "guava";
    rev = "c3bd8eb49f9b355a140cbb56ab592e973fea4c0d";
    sha256 = "0kasch20paz8786szm7chz0ahqfcm4m89754kfckzpp7mnis4nrs";
  };

  buildInputs = [ jdk findbugs-jsr305-jar inject-jsr330-jar ];

  buildPhase = ''
      mvn install -o -DskipTests=true
  '';

  installPhase = ''
      mkdir -p $out/share/java
      cp  "guava/target/guava-${version}.jar" $out/share/java
  '';

  meta = {
    description = "Several of Google's java core libraries";
    homepage = https://github.com/google/guava;
    license = stdenv.lib.licenses.asl20;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
