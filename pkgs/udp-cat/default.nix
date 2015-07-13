{ stdenv, fetchFromGitHub, debug ? false }:

stdenv.mkDerivation rec {
  name = "udp-cat-2.0.2";

  src = fetchFromGitHub {
    owner = "samuelrivas";
    repo = "udp-cat";
    rev = "64164f191751d19dd09dea39173ecff205406176";
    sha256 = "18s55yhxkwh6vhq3gn5v10q5c791x8ca3qs31pw4a0phxc5mr6qz";
  };

  buildInputs = [ ];
  dontStrip = debug;

  installPhase = ''
    installBin udp-cat
  '';

  meta = {
    description = "Dump data from an udp socket. Like nc -u but with multicast support";
    homepage = https://github.com/samuelrivas/udp-cat;
    license = stdenv.lib.licenses.gpl1;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
