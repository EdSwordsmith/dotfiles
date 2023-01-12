let
  user_annuminas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDr6cqDPQKapijMfCxwXAFSniL5Tl1WMMcJ1dUcB3yhy";
  user_minastirith = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHdqPxNoMvoAdSQMug5H2aMnXXQgSpEyh96dibVtxRqd";
  user_dolamroth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0/hgrBsENtRhS2KxIsZrXiW5vVlkwxGCCQ14TUtGVd";
  user_fornost = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH9fsZ6NiBTcHQlT7GvX0gjMXkVB1FA4d0ryckaTIod2";
  users = [ user_annuminas user_minastirith user_dolamroth user_fornost ];

  system_minastirith = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICqqMgK+dTe40QHWrUfRZgBNtBMYUU/4KBt9Lk4iT3aY";
  systems = [ system_minastirith ];
in
{
  "pombobot.age".publicKeys = users ++ systems;
  "djtobis.age".publicKeys = users ++ systems;
  "NUNO.mp4.age".publicKeys = users ++ systems;
}
