{
  configDir,
  ...
}: {
  security.pki.certificateFiles = [
    "${configDir}/certs/rnl.crt"
    "${configDir}/certs/ist.crt"
  ];
}
