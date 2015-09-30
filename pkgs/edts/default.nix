{
  erlang,
  fetchzip,
  fetchFromGitHub,
  stdenv
 }:

let
  package = "edts";
  edts-git-version = "70dfcfd8cc448c854fb67d65e005ba00e77384c5";
  curriedFetch = owner: args: fetchFromGitHub (with args; {
    inherit owner repo rev sha256;
  });
in let
  fetchFromTjarvstrand = curriedFetch "tjarvstrand";
  fetchFromBasho = curriedFetch "basho";
  fetchFromMagnars = curriedFetch "magnars";
in let
  edts = fetchFromTjarvstrand {
    repo = "edts";
    rev = edts-git-version;
    sha256 = "0vsrcvrd02nx647gxp65r548qlxg50w73dy0rs1lxwy6mdgp0npv";
  };
  webmachine = fetchFromBasho {
    repo = "webmachine";
    rev = "1.10.6";
    sha256 = "1bbp27z0mijyrrlgwjrm632hiaz8zdvdd68fy8w56ixa1xvrlcab";
  };
  meck = fetchFromGitHub {
    owner = "eproxus";
    repo = "meck";
    rev = "0.8.2";
    sha256 = "0s4qbvryap46cz63awpbv5zzmlcay5pn2lixgmgvcjarqv70cbs7";
  };
  lager = fetchFromBasho {
    repo = "lager";
    rev = "2.0.3";
    sha256 = "087qfj4qiybbayz155vnndww06rab6jxqzsrkcxq2kd5xpg88jnj";
  };
  autoComplete = fetchFromTjarvstrand {
    repo = "auto-complete";
    rev= "b77d56d7c2651e31c3e48b51541cd5d532d95731";
    sha256 = "05rsbpkvaq6xfvd7zzybvqpshhsl7cxw52mwaaml18jvz1g4sjmk";
  };
  autoHighlightSymbolMode = fetchFromTjarvstrand {
    repo = "auto-highlight-symbol-mode";
    rev = "7cf81aa0d7e9e43f7363523057a54cdcc46e1354";
    sha256 = "119rgm9fmpydaj474j590a2r77flikfrnrvzx3xc52ahb9c5h8vh";
  };
  popupEl = fetchFromTjarvstrand {
    repo = "popup-el";
    rev = "f15c82bf423e6d49cf107836ba1ce39fc1138933";
    sha256 = "0gmc77acygd4664fxdq0qxpywwpkgmkxni9bpkjfjbs1p2nsf3d4";
  };
  posTip = fetchFromTjarvstrand {
    repo = "pos-tip";
    rev = "09597a77affbb948f9cf970d8a6aa4ff7e52542b";
    sha256 = "1592dbhy56rd5rz6svnhdp9mnh72wnvqr5aw7flrks9brlbnj217";
  };
  dashEl = fetchFromMagnars {
    repo = "dash.el";
    rev = "2dfd7488047593ebb24c5124e86ca3ad9115183f";
    sha256 = "0gfm55nsywfn7xn84wvh34yyd6mcz22jqzj5k0b9zpihxxh3wdqg";
  };
  sEl = fetchFromMagnars {
    repo = "s.el";
    rev = "889d00eb3fd53c2b939fd3cce549a7a5a5f9c3dc";
    sha256 = "0v3adqqj4rdg496ykzk5yc3z6mimfvzc0j9b866v60h7l1fbdaz4";
  };
  eproject = fetchFromGitHub {
    owner = "jrockway";
    repo = "eproject";
    rev = "cf9a9e6270e5ea39e0b73a1f57ff4b662a6df92d";
    sha256 = "1cbs91lxngq7z7b53w0crp2sx7qbdfz717z5rd7wvw2vwi4cfh7l";
  };
  fEl = fetchFromGitHub {
    owner = "rejeep";
    repo = "f.el";
    rev = "8e2989d8476ec4e67f7207b04faf68fa2d734997";
    sha256 = "1l7s9arcfb7waxfn4254lm43xq45462qz4hg2hff4bbmv37qjdxy";
  };

in
stdenv.mkDerivation rec {
  version = "0.0.0";
  name = "${package}-${version}";

  srcs = [
    autoComplete
    autoHighlightSymbolMode
    dashEl
    edts
    eproject
    fEl
    lager
    meck
    popupEl
    posTip
    sEl
    webmachine
  ];

  EDTS_SKIP_SUBMODULE_UPDATE="true";
  sourceRoot = "edts-${edts-git-version}-src";
  postUnpack = ''
    for app in webmachine meck lager; do
      cp -r "$app"-* "$sourceRoot/lib/$app"
    done
    for app in auto-complete eproject popup-el pos-tip \
               auto-highlight-symbol-mode; do
      cp -r "$app"-*/* "$sourceRoot/elisp/$app/" # emacs */
    done
    for app in f s dash; do
      cp -r "$app.el"-*/* "$sourceRoot/elisp/$app/" # emacs */
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
