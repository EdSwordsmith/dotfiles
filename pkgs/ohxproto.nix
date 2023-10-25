{
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "0xproto";
  version = "1.300";
  underscoreVersion = builtins.replaceStrings ["."] ["_"] version;

  src = fetchzip {
    url = "https://github.com/0xType/0xProto/releases/download/${version}/0xProto_${underscoreVersion}.zip";
    sha256 = "sha256-RanIMf9P2lFOF3kJS6jMlh/X6jttofbHSqFUJxWSqKk=";
  };

  dontConfigure = true;
  dontPatch = true;
  dontBuild = true;
  dontFixup = true;
  doCheck = false;

  installPhase = ''
    runHook preInstall
    install -Dm644 -t $out/share/fonts/opentype/ *.otf
    install -Dm644 -t $out/share/fonts/truetype/ *.ttf
    runHook postInstall
  '';
}
