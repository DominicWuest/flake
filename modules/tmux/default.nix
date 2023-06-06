{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile (../../dotfiles/tmux);
    plugins = with pkgs; [
      # Resurrect plugin
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }

      # Continuum plugin
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5'
        '';
      }

      # Gruvbox plugin
      {
        plugin = tmuxPlugins.gruvbox;
        extraConfig = "set -g @tmux-gruvbox 'dark'";
      }
    ];
  };

  xresources.extraConfig = builtins.readFile (../../dotfiles/Xresources);
}
