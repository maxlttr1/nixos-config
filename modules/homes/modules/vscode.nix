{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    #package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        # Python
        ms-python.python
        ms-python.vscode-pylance
        ms-python.vscode-python-envs
        ms-python.debugpy
        # Nix
        jnoortheen.nix-ide
        # C/C++
        ms-vscode.cpptools
        ms-vscode.cmake-tools
        # llvm-vs-code-extensions.vscode-clangd
        # Javascript
        robole.javascript-snippets
        christian-kohler.path-intellisense # autocompletes filenames 
        # Java
        vscjava.vscode-java-debug
        vscjava.vscode-java-dependency
        redhat.java
        vscjava.vscode-java-test
        # HTML/CSS and Web
        ecmel.vscode-html-css
        # Language pack
        james-yu.latex-workshop
        yzhang.markdown-all-in-one
        # Yaml
        redhat.vscode-yaml
        # Utilities
        ms-vsliveshare.vsliveshare
        formulahendry.auto-rename-tag
        tomoki1207.pdf
        pkief.material-icon-theme
        zhuangtongfa.material-theme
        # sonarsource.sonarlint-vscode # Linter
        mkhl.direnv
        vscodevim.vim
      ];
      userSettings = {
        "editor.fontFamily" = "'Mononoki Nerd Font Mono'";
        "editor.cursorBlinking" = "phase";
        "editor.cursorSmoothCaretAnimation" = "on";
        "explorer.confirmDelete" = false;
        "extensions.ignoreRecommendations" = true;
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
        "git.autofetch" = "all";
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "git.smartCommitChanges" = "all";
        "redhat.telemetry.enabled" = false;
        "telemetry.enableTelemetry" = false;
        "telemetry.feedback.enabled" = false;
        "telemetry.telemetryLevel" = "off";
        "window.titleBarStyle" = "custom";
        "workbench.colorTheme" = "One Dark Pro Night Flat";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
        "typescript.suggest.paths" = false; # To use Path Intellisense completion instead of the default
        "javascript.suggest.paths" = false; # To use Path Intellisense completion instead of the default
        "cmake.options.statusBarVisibility" =  "visible";
        "explorer.confirmDragAndDrop" = false;
        "editor.insertSpaces" = false;
        "editor.tabSize" = 4;
        "editor.detectIndentation" = false;
        "python.useEnvironmentsExtension" = true;
      };
    };
  };
}
