{
  configDir,
  secretsDir,
  ...
}: let
  signingKeyPath = "/home/eduardo/.ssh/id_ed25519.signing";
  signers = "${configDir}/git/allowed_signers";
in {
  age.secrets.git-signing = {
    file = "${secretsDir}/git-signing.age";
    path = signingKeyPath;
    owner = "eduardo";
    group = "users";
    mode = "0400";
  };

  hm.programs.git = {
    signing = {
      signByDefault = true;
      key = signingKeyPath;
    };

    settings = {
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = signers;
    };
  };
}
