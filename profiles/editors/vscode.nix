{pkgs, ...}: {
  hm.programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;

    extensions = with pkgs.unstable.vscode-extensions;
      [
        arrterian.nix-env-selector
        github.copilot
        ms-vsliveshare.vsliveshare

        # Python
        ms-python.python
        ms-toolsai.jupyter

        # Rust
        rust-lang.rust-analyzer

        # JavaScript
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode

        # Lua
        sumneko.lua
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "ayu";
          publisher = "teabyii";
          version = "1.0.5";
          sha256 = "sha256-+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
        }
      ];

    # Got annoyed at the errors you get from the settings.json file being read only
    # This gives more headaches than it solves
    #userSettings = {
    #  "editor.fontSize" = 20;
    #  "editor.fontFamily" = "JetBrains Mono, Menlo, monospace";
    #  "editor.fontLigatures" = true;
    #
    #  "workbench.colorTheme" = "Ayu Dark";
    #  "workbench.iconTheme" = "ayu";

    #  "terminal.integrated.fontFamily" = "JetBrains Mono";
    #  "terminal.integrated.fontSize" = 20;

    #  "window.menuBarVisibility" = "hidden";
    #};
  };
}
