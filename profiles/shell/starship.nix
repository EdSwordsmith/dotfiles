{...}: {
  hm.programs.starship = {
    enable = true;

    settings = {
      scan_timeout = 1000;
      format = "$username[@](bold green)$hostname$directory$all";

      username = {
        show_always = true;
        format = "[\\[](bold bright-red)[$user]($style)";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "bold blue";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style)[\\]](bold bright-red) ";
      };
    };
  };
}
