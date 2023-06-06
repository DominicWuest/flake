{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      golang.go
      christian-kohler.path-intellisense
      eamodio.gitlens
      jdinhlife.gruvbox
      gruntfuggly.todo-tree
      vscodevim.vim
      streetsidesoftware.code-spell-checker
      jnoortheen.nix-ide
      emmanuelbeziat.vscode-great-icons
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-todo-highlight";
        publisher = "wayou";
        version = "1.0.5";
        sha256 = "sha256-CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
      }
    ];
  };
}
