{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;	
    vimAlias = true;
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        /*options = {
           tabstop = 3; 
           shiftwidth = 3;
        };*/
        lsp= {
          enable = true;
          formatOnSave = true;
        };
        theme = {
          enable = true;
          name = "onedark";
          style = "dark";
        };
        languages = {
          python.enable = true;
          nix.enable = true;
          java.enable = true;
          json.enable = true;
          html.enable = true;
          css.enable = true; 
          yaml.enable = true;
          clang.enable = true;
          markdown.enable = true;
        };
        utility.undotree = {
           enable = true;
        };
        treesitter = {
          enable = true;
          autotagHtml = true;
        };
        filetree.nvimTree.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
      };
    };
  };
}
