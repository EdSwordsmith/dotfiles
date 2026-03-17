let
  user_annuminas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDr6cqDPQKapijMfCxwXAFSniL5Tl1WMMcJ1dUcB3yhy";
  user_dolamroth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINXBgSSmDUpSOQb8+trWtlClCwV25h0jBSCwFjm5w2bF";
  user_fornost = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9fsZ6NiBTcHQlT7GvX0gjMXkVB1FA4d0ryckaTIod2";
  users = [user_annuminas user_dolamroth user_fornost];

  system_dolamroth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC46he9/EHBXFfVJDLE7K6i++V4xZrjjPK7v7XVn1kM6";
  systems = [system_dolamroth];

  keys = users ++ systems;
  secrets = [
    "cloudflare.age"
    "ncdbpass.age"
    "cftunnel.age"
  ];
in
  builtins.listToAttrs (map (secret: {
      name = secret;
      value.publicKeys = keys;
    })
    secrets)
