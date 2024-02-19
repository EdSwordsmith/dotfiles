{
  configDir,
  inputs,
  ...
}: {
  security.pki.certificateFiles = [
    inputs.rnl-ca
    "${configDir}/certs/ist.crt"
  ];
}
