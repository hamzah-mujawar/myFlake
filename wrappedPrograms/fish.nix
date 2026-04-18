{
  inputs,
  lib,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: let
    fishConf =
      pkgs.writeText "fishy-fishy"
      # fish
      ''
               function fish_prompt
                   string join "" -- (set_color red) "[" (set_color yellow) $USER (set_color green) "@" (set_color blue) $hostname (set_color magenta) " " $(prompt_pwd) (set_color red) ']' (set_color normal) "\$ "
               end

               set fish_greeting
               fish_vi_key_bindings

        bind p fish_clipboard_paste
        bind -s --preset -M visual -m default Y "fish_clipboard_copy; commandline -f end-selection repaint-mode"

               ${lib.getExe pkgs.zoxide} init fish | source

               if type -q direnv
                   direnv hook fish | source
               end

               set -x LESS_TERMCAP_mb (printf "\033[01;31m")
               set -x LESS_TERMCAP_md (printf "\033[01;31m")
               set -x LESS_TERMCAP_me (printf "\033[0m")
               set -x LESS_TERMCAP_se (printf "\033[0m")
               set -x LESS_TERMCAP_so (printf "\033[01;44;33m")
               set -x LESS_TERMCAP_ue (printf "\033[0m")
               set -x LESS_TERMCAP_us (printf "\033[01;32m")
      '';
  in {
    packages.fish = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.fish;
      runtimeInputs = [
        pkgs.zoxide
      ];
      flags = {
        "-C" = "source ${fishConf}";
      };
    };
  };
}
