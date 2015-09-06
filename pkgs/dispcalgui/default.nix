# broken:
#
# Need to export XDG_CONFIG_HOME to $out/etc/xdg

{ stdenv, buildPythonPackage, fetchzip, libX11, libXxf86vm, libXext,
  libXinerama, libXrandr, wxPython }:

let
  version = "3.0.4.1";
  package-name = "dispcalgui";
in
buildPythonPackage rec {
  name = "${package-name}-${version}";

  src = fetchzip {
    url = "http://downloads.sourceforge.net/project/dispcalgui/release/3.0.4.1/dispcalGUI-3.0.4.1.tar.gz";
    sha256 = "0fsyg1kyl5bvv5mk826gh72pqr2bj2wjb1dxcjfqyzwnmnhc9i3l";
  };

  preInstall = ''
    XDG_CONFIG_HOME="$out/etc/xdg"
    export XDG_CONFIG_HOME
  '';

  installPhase = ''runHook preInstall

mkdir -p "$out/lib/python2.7/site-packages"

export PYTHONPATH="$out/lib/python2.7/site-packages:$PYTHONPATH"

XDG_CONFIG_HOME=/tmp/foo/config-from-nix /nix/store/pbi1lgank10fy0xpjckbdpgacqw34dsz-python-2.7.9/bin/python2.7 setup.py install \
  --install-lib $out/lib/python2.7/site-packages \
  --old-and-unmanageable \
  --prefix "$out"

eapth="$out/lib/python2.7"/site-packages/easy-install.pth
if [ -e "$eapth" ]; then
    # move colliding easy_install.pth to specifically named one
    mv "$eapth" $(dirname "$eapth")/dispcalgui-3.0.4.1.pth
fi

rm -f "$out/lib/python2.7"/site-packages/site.py*

runHook postInstall
'';

  buildInputs = [ libX11 libXxf86vm libXext libXinerama libXrandr wxPython ];

  meta = {
    description = "Open Source Display Calibration and Characterization powered by Argyll CMS.";
    homepage = http://dispcalgui.hoech.net/;
    license = stdenv.lib.licenses.gpl3;
    maintainers = [ "Samuel Rivas <samuelrivas@gmail.com>" ];
  };
}
