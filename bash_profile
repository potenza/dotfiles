set -o vi

export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# history
HISTSIZE=5000
HISTFILESIZE=10000
HISTTIMEFORMAT="%m/%d/%y %T "
# append instead of overwrite the history
shopt -s histappend
# have bash immediately add commands to our history instead of waiting for the end of each session
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# turn off suspend and resume feature
stty -ixon

# aliases
alias ls='ls -FG'
alias l='ls -FGl'
alias ll='ls -FGl'
alias la='ls -FGla'
alias ltr='ls -FGltr'
alias gco='git checkout'
alias gdc='git diff --cached'
alias gdf='git diff'
alias gst='git status'
alias gbl='git branch'
alias p='cd ~/projects'

# git bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ \(\1$(parse_git_dirty)\)/"
}

function parse_git_dirty {
  git diff-index --quiet --cached HEAD --ignore-submodules -- 2> /dev/null && git diff-files --quiet --ignore-submodules 2> /dev/null || echo ' *'
}

export PS1='\[\e[31m\]\u@mbp\[\e[m\] \[\e[34m\][\W]\[\e[m\]\[\e[32m\]$(parse_git_branch)\[\e[m\] $ '

export PATH="/usr/local/opt/node@8/bin:$PATH"

# use chruby to switch ruby installs
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
