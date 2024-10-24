{ pkgs }:
let
  pluginPkgs = with pkgs; [
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
    zsh-abbr
  ];

  plugins = with pkgs; [
    "${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "${zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
    "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "${zsh-abbr}/share/zsh/zsh-abbr/abbr.plugin.zsh"
  ];
in
{
  inherit plugins pluginPkgs;
}
