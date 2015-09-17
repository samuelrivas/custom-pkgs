{
  erlang,
  fetchzip,
  stdenv
 }:

let
  package = "edts";
  git-sha = "70dfcfd8cc448c854fb67d65e005ba00e77384c5";
  github = "https://github.com";
in let
  edts = fetchzip {
    name = "edts";
    url = "${github}/tjarvstrand/edts/archive/${git-sha}.zip";
    sha256 = "0vsrcvrd02nx647gxp65r548qlxg50w73dy0rs1lxwy6mdgp0npv";
  };

  webmachine = fetchzip {
    name = "webmachine";
    url = "${github}/basho/webmachine/archive/1.10.6.zip";
    sha256 = "1bbp27z0mijyrrlgwjrm632hiaz8zdvdd68fy8w56ixa1xvrlcab";
  };

  meck = fetchzip {
    name = "meck";
    url = "${github}/eproxus/meck/archive/0.8.2.zip";
    sha256 = "0s4qbvryap46cz63awpbv5zzmlcay5pn2lixgmgvcjarqv70cbs7";
  };

  lager = fetchzip {
    name = "lager";
    url = "${github}/basho/lager/archive/2.0.3.zip";
    sha256 = "087qfj4qiybbayz155vnndww06rab6jxqzsrkcxq2kd5xpg88jnj";
  };

in
stdenv.mkDerivation rec {
  version = "0.0.0";
  name = "${package}-${version}";

  srcs = [ edts webmachine meck lager ];

  sourceRoot = "edts";
  postUnpack = ''
    for app in webmachine meck lager; do
      cp -r "$app" "$sourceRoot/lib"
    done
  '';

  buildInputs = [ erlang ];

  meta = {
    description = "The Erlang Development Tool Suite (EDTS)";
    homepage = https://github.com/tjarvstrand/edts;
    license = stdenv.lib.licenses.lgpl3;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
    longDescription = "The Erlang Development Tool Suite (EDTS) is a package of
      useful development tools for working with the Erlang programming language
      in Emacs. It bundles a number of useful external packages, together with
      specialized Erlang plugins for them, and its own features to create a
      complete and efficient development environment that is easy to set up.";
  };
}
