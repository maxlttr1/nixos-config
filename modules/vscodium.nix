{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    vscodium 
    (vscode-with-extensions.override {
    vscode = vscodium;
    vscodeExtensions = with vscode-extensions; [
      # Python
      ms-python.python
      ms-python.black-formatter
      # Nix
      bbenoist.nix
      jnoortheen.nix-ide
      # R
      rdebugger.r-debugger
      reditorsupport.r
      # Language pack
      franneck94.vscode-c-cpp-dev-extension-pack # C/C++ pack
      gydunhn.javascript-essentials # Javascript pack
      edwinkofler.vscode-hyperupcall-pack-java # Java pack
      ecmel.vscode-html-css # HTML CSS
      redhat.ansible
      james-yu.latex-workshop
      yzhang.markdown-all-in-one
      # Utilities
      formulahendry.auto-rename-tag
      esbenp.prettier-vscode
      ms-azuretools.vscode-docker
      redhat.vscode-yaml
      tomoki1207.pdf
      pkief.material-icon-theme
      cweijan.vscode-mysql-client2
      formulahendry.code-runner
      ms-vscode.live-server
      usernamehw.errorlens
      sonarsource.sonarlint-vscode
      matt-rudge.auto-open-preview-panel
      oderwat.indent-rainbow
      hediet.vscode-drawio
      naumovs.color-highlight
      pomdtr.excalidraw-editor
      vivaxy.vscode-conventional-commits
    ];
  })
  ];
}