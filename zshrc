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
if [[ "$ENV_TYPE" == "docker" ]]; then
    antigen theme robbyrussell
else
    antigen theme romkatv/powerlevel10k
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Tell Antigen that you're done.
antigen apply

# eval "$(fasd --init auto)"

# export PATH=$HOME/go/bin:$HOME/CUDA/bin:$HOME/Applications:$PATH
export PATH=$HOME/Applications:$PATH
# export LD_LIBRARY_PATH=$HOME/CUDA/lib64:$LD_LIBRARY_PATH

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"
# export CLOUD="/Users/yashsavani/Library/Mobile Documents/com~apple~CloudDocs"
export XDG_CONFIG_HOME=$HOME/.config

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
alias icat="kitty +kitten icat"
alias devrun='srun --mem=20G --gres=gpu:1 --exclude=locus-1-13 --time=2-00:00:00 --pty /opt/zsh/5.8/bin/zsh'
alias devbig='srun --mem=20G --gres=gpu:A6000:1 --exclude=locus-1-13 --time=2-00:00:00 --pty /opt/zsh/5.8/bin/zsh'
function devon {
    session="workspace"
    window="dev"
    tmux has-session -t $session 2>/dev/null

    if [ $? != 0 ]; then
        tmux new-session -d -s $session -n $window "$(alias devrun | cut -d\' -f2)"
        # tmux send-keys -t $session:$window "devrun" C-m
    fi
    tmux attach-session -t $session
}
# alias devon="tmux new-session -s $session \"srun --exclude 'locus-1-[21,25,29]' --mem=20G --gres gpu:1 --time=2-00:00:00 --pty /opt/zsh/5.8/bin/zsh\""
alias sq='squeue -o "%.9i %.9P %.30j %.8u %.2t %.10M %.6D %.25S %.25e %.10N"'
alias sqme='squeue -u `whoami`'
alias sqservers='squeue -u `whoami` -o "%.10N"'
function watcha {
   watch -n 0.5 $(alias "$1" | cut -d\' -f2)
}
alias rsyncd="$HOME/.config/rsyncd.sh"
function sshl {
    ssh locus-$1-$2 /opt/zsh/5.8/bin/zsh
}
alias pbcopy="kitty +kitten clipboard"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ysavani/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ysavani/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/ysavani/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/ysavani/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/ysavani/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/ysavani/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

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
        zsh kitty gcc gxx_linux-64 git git-lfs make cmake nodejs \
        lazygit exa bat ytop nvtop snakeviz fd sd ripgrep \
        jupyter jupyterlab neovim python-lsp-server black \
        flake8 ipython ipdb numpy matplotlib pandas scikit-learn \
        scipy statsmodels scikit-learn-intelex seaborn submitit
    mamba install -y -c "nvidia/label/cuda-11.8.0" cuda-toolkit
    mamba install -y equinox optax diffrax
    mamba install -y -c pytorch -c nvidia -c conda-forge \
        pytorch torchvision torchaudio pytorch-cuda=11.8 \
        lightning tensorboard einops wandb
    mamba install -y transformers diffusers accelerate
    # pip3 install --upgrade "jax[cuda11_pip]" \
    #     -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
} 

function createenv {
    mamba update -y conda mamba
    mamba create -y -n $1 python=3.10
    mamba activate $1
    setupenv_linux_x86_64
}

function updateall {
    hostname=$(hostname)
    if [[ $hostname == locus* ]]; then
        echo "Updating on locus"
    else
        echo "Updating on localgpu"
        sudo apt update
        sudo apt upgrade
        sudo apt autoremove
        sudo apt autoclean
    fi
    antigen update
    mamba update -y conda mamba
    mamba clean -y --all
    # mamba update --all -y -c pytorch -c nvidia -c conda-forge
}

