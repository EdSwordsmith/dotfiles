{pkgs, ...}: {
  hm.programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;

    extensions = with pkgs.unstable.vscode-extensions; [
      arrterian.nix-env-selector

      # Flutter
      dart-code.dart-code
      dart-code.flutter

      # Python
      ms-python.python
      ms-toolsai.jupyter

      # Rust
      rust-lang.rust-analyzer

      # JavaScript
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
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
