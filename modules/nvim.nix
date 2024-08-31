{ inputs, ... };
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;	
  }

  opts = {
    number = true;
    relativenumber = false;
    tabstop = 2
    smartindent = true;
    hlsearch = true;
    incsearch = true;
    spell = true;
  }
}
