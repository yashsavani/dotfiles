# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export SHELL="/usr/local/bin/zsh"

source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen theme romkatv/powerlevel10k

antigen bundle git
antigen bundle pip
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration
export PATH=$PATH:/usr/local/sbin:/usr/local/anaconda3/bin:${HOME}/.local/bin

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

alias ls="exa --icons"
alias ll="exa -lh --git --group-directories-first --icons"
alias vim="nvim --startuptime /tmp/nvim-startuptime"
alias updateall="omz update && brew update && brew upgrade && brew cleanup && antigen update&& conda update --all -y && pip3 install -U pip3 setuptools wheel"
alias lg="lazygit"
alias slocus="kitty +kitten ssh locus"
alias sgpu="kitty +kitten ssh localgpu"
alias icat="kitty +kitten icat"
alias vconf="(cd ~/.config && vim)"
alias sshfslocus="umount -f ~/dev/locus || sshfs -o kernel_cache,cache=yes,compression=no ysavani@locus.cs.cmu.edu:/home/ysavani ~/dev/locus"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/usr/local/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/usr/local/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -e

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

if [ -e /Users/yashsavani/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/yashsavani/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
