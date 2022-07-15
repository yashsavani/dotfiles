# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit
compinit

# allow tab completions in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## history
#setopt APPEND_HISTORY
## for sharing history between zsh processes
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors

source $HOME/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle pip
antigen bundle command-not-found

# Zsh Users bundles
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle unixorn/fzf-zsh-plugin@main

# Load the theme
# antigen theme robbyrussell
antigen theme git@github.com:romkatv/powerlevel10k.git

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Tell Antigen that you're done
antigen apply

# eval "$(fasd --init auto)"

export PATH=$PATH:/usr/local/sbin:${HOME}/.local/bin

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

alias ls="exa --icons"
alias ll="exa -lha --icons --group-directories-first --git"
alias vim="nvim --startuptime /tmp/nvim-startuptime"
alias updateall="brew update && brew upgrade && brew cleanup && antigen update && mamba update --all -y -c conda-forge -c pytorch"
alias lg="lazygit"
alias slocus="kitty +kitten ssh locus"
alias sgpu="kitty +kitten ssh localgpu"
alias icat="kitty +kitten icat"
alias vconf="(cd ~/.config && vim)"
alias sshfslocus="umount -f ~/dev/locus || sshfs -o kernel_cache,cache=yes,compression=no ysavani@locus.cs.cmu.edu:/home/ysavani ~/dev/locus"
# alias setuptex="(find ~/.config/latex ! -name main.tex ! -name latex | xargs -I{} ln -sf {} .) && cp $HOME/.config/latex/main.tex ."
alias setuptex="cp $HOME/.config/latex/main.tex . && cp $HOME/.config/latex/Makefile ."
alias rsyncd="$HOME/.config/rsyncd.sh"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY_TIME

bindkey -e

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source /usr/share/doc/fzf/examples/key-bindings.zsh
