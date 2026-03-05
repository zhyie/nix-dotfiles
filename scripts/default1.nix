{ stdenv, lib, pkgs, ... }:

stdenv.mkDerivation {
  name = "scripts";
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin

    cp ${src}/audio.sh $out/bin/audio.sh
    cp ${src}/battery.sh $out/bin/battery.sh
    cp ${src}/backlight.sh $out/bin/backlight.sh
    cp ${src}/datetime.sh $out/bin/datetime.sh
    cp ${src}/network.sh $out/bin/network.sh

    for s in $out/bin/*; do
      chmod +x "$s"
    done
  '';
}
