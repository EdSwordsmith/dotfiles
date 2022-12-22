{ config, options, pkgs, lib, inputs, configDir, secretsDir, ... }:

{
  security.pki.certificateFiles = [
    "${configDir}/certs/rnl.crt"
    "${configDir}/certs/ist.crt"
  ];
}
