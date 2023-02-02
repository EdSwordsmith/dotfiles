{ config, options, pkgs, lib, ... }:

{
  hm.programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;

    extensions = with pkgs.unstable.vscode-extensions; [
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      ms-python.python
      github.copilot
      ms-toolsai.jupyter
      rust-lang.rust-analyzer
      ms-dotnettools.csharp
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "ayu";
        publisher = "teabyii";
        version = "1.0.5";
        sha256 = "sha256-+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
      }
    ];

    userSettings = {
      "editor.fontSize" = 20;
      "editor.fontFamily" = "JetBrains Mono, Menlo, monospace";
      "editor.fontLigatures" = true;

      "workbench.colorTheme" = "Ayu Dark";
      "workbench.iconTheme" = "ayu";

      "terminal.integrated.fontFamily" = "JetBrains Mono";
      "terminal.integrated.fontSize" = 20;

      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.enableLanguageServer" = true;
      "window.menuBarVisibility" = "hidden";
    };
  };
}
