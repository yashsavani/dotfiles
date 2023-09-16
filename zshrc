#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#
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

# Tell Antigen that you're done.
antigen apply

# eval "$(fasd --init auto)"

export PATH=$PATH:/usr/local/sbin:${HOME}/.local/bin:/usr/local/opt/openjdk/bin

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
export CLOUD="/Users/yashsavani/Library/Mobile Documents/com~apple~CloudDocs"
export XDG_CONFIG_HOME=$HOME/.config

# Load environment variables from the specified secrets file if it exists
SECRETS_PATH="$XDG_CONFIG_HOME/secrets.env"
if [ -f "$SECRETS_PATH" ]; then
    while IFS= read -r line; do
        # Remove leading whitespace from the line
        line=$(echo "$line" | sed -e 's/^[[:space:]]*//')
        
        # Check if the line is empty or starts with a comment character '#'
        if [ -n "$line" ] && ! [[ "$line" =~ ^\# ]]; then
            export "$line"
        fi
    done < "$SECRETS_PATH"
fi

# Aliases
alias ls="exa --icons"
alias lls="ls"
alias ll="exa -lha --icons --group-directories-first --git"
alias vim="nvim --startuptime /tmp/nvim-startuptime"
alias icat="kitty +kitten icat"
alias slocus="kitty +kitten ssh locus"
alias sgpu="kitty +kitten ssh localgpu"
alias brave="open -a \"Brave Browser\""
alias setuptex="cp $XDG_CACHE_HOME/latex/main.tex ."

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/mambaforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/mambaforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/mamba.sh" ]; then
    . "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)" # Brew Perl

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

function setupenv_macos_arm {
    mamba install -y \
        jupyter jupyterlab neovim python-lsp-server black \
        flake8 ipython ipdb numpy matplotlib pandas scikit-learn \
        scipy statsmodels snakeviz seaborn submitit
    mamba install -y -c pytorch \
        pytorch::pytorch torchvision torchaudio \
        lightning tensorboard einops wandb
    mamba install -y jax
} 

function setupenv_linux_x86_64 {
    mamba install -y \
        zsh kitty gcc gxx_linux-64 git make cmake nodejs \
        lazygit exa bat ytop nvtop snakeviz fd sd ripgrep \
        jupyter jupyterlab neovim python-lsp-server black \
        flake8 ipython ipdb numpy matplotlib pandas scikit-learn \
        scipy statsmodels scikit-learn-intelex seaborn submitit
    mamba install -y -c pytorch -c nvidia \
        pytorch torchvision torchaudio pytorch-cuda=11.8 \
        lightning tensorboard transformers diffusers einops wandb
    pip3 install --upgrade "jax[cuda11_pip]" \
        -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
}

function createenv {
    mamba create -y -n $1 python=3.10
    mamba activate $1
    setupenv_macos_arm
}

function updateall {
    brew update
    brew upgrade
    brew cleanup
    antigen update
    mamba update -y conda mamba
}

