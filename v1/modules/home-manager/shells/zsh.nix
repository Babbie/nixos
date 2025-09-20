{ config, lib, pkgs, ... }:

with lib; {
  options = {
    zsh.enable = mkEnableOption "Enables custom zsh config";
    zsh.userPromptColor = mkOption {
      default = "green";
      description = "Prompt color for non-root user";
    };
    zsh.rootPromptColor = mkOption {
      default = "red";
      description = "Prompt color for root user";
    };
  };

  config = mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = config.xdg.configHome + "/zsh";
      defaultKeymap = "viins";
      autosuggestion.enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "ls --color=auto";
        ll = "ls -al --color=auto";
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" "cursor" ];
      };
      history = {
        save = 1000000000;
        size = 1000000000;
      };
      completionInit = "
        zstyle ':completion:*' auto-description 'specify: %d'
        zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
        zstyle ':completion:*' expand suffix
        zstyle ':completion:*' format 'Completing %d'
        zstyle ':completion:*' group-name ''
        zstyle ':completion:*' ignore-parents parent pwd ..
        zstyle ':completion:*' list-colors ''
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]} r:|[._-]=** r:|=**' '+l:|=* r:|=*'
        zstyle ':completion:*' menu select=0
        zstyle ':completion:*' preserve-prefix '//[^/]##/'
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true
        autoload -U compinit && compinit
      ";
      initContent = ''
        setopt beep extendedglob nomatch transientrprompt
        
        case $(tty) in  
          /dev/tty[0-9]*)
            if [ "$(whoami)" = "root" ] ; then
              color="${config.zsh.rootPromptColor}"
            else
              color="${config.zsh.userPromptColor}"
            fi  
        
            PS1="%K{$color}%F{black} %?%K{black}%F{$color}) %~%k%F{black})%f
%K{$color}%F{black} %n%K{black}%F{$color}) %m%k%F{black})%f "
            function set-prompt () {
              case ''${KEYMAP} in
                (vicmd)     RPS1="%F{$color} (%K{$color}%F{black}NORMAL %k%f" ;;
                (*)         RPS1="" ;;
              esac
            }
            ;;  
          *)  
            if [ "$(whoami)" = "root" ] ; then
              color="${config.zsh.rootPromptColor}"
            else
              color="${config.zsh.userPromptColor}"
            fi  
        
            PS1="%K{$color}%F{black} %?%K{black}%F{$color} %~%k%F{black}%f
%K{$color}%F{black} %n%K{black}%F{$color} %m%k%F{black}%f "
            function set-prompt () {
              case ''${KEYMAP} in
                (vicmd)     RPS1="%F{$color} %K{$color}%F{black}NORMAL %k%f" ;;
                (*)         RPS1="" ;;
              esac
            }
            ;;  
        esac
        
        function zle-line-init zle-keymap-select {
          set-prompt
          zle reset-prompt
        }
        
        zle -N zle-line-init
        zle -N zle-keymap-select
	set-prompt
      '';
    };
  
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
