
[ -f $HOME/emsdk/emsdk_env.sh ] && source $HOME/emsdk/emsdk_env.sh > /dev/null

[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

# This appends to the zsh-completion functions instead of overwriting
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions StoppedJobs)

autoload -Uz compinit promptinit
promptinit
compinit

alias tree='tree -I "node_modules|bower_components|CMakeFiles|_site|static"'

export TERM=xterm-256color
export EDITOR=vim
export KEYTIMEOUT=1 # kill lag when escaping to vi mode
export HISTCONTROL="ignoreboth:erasedumps"

HISTFILE=~/.histfile
HISTSIZE=65535
SAVEHIST=65535
setopt appendhistory autocd

unsetopt beep

setxkbmap -layout us -option ctrl:swapcaps

# Disable <C-s> scroll-lock / SFC on-off
stty -ixon

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# Override border width whenever a terminal is opened.
# bspc config -n focused border_width 1

# For some reason opening lemonbar is fucking this up
# bspc config top_padding 80


# Manage ssh-agents with keychain
# keychain > /dev/null 2>&1
# if [ $? -eq 0 ]; then
#   eval $(keychain --eval --agents ssh -Q --quiet $HOME/.ssh/id_ecdsa)
# fi

# some completion speeding
__git_files () {
    _wanted files expl 'local files' _files
}

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/scallywag/.zshrc'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' accept-exact '*(N)'
setopt completealiases

#
# And set some styles...
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' rehash yes
zstyle -e ':completion:*:approximate:*' max-errors \
          'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'


# Completion for lowercase vbox commands
VBoxManage > /dev/null 2>&1
if [ $? -eq 0 ]; then
  compdef vboxmanage=VBoxManage
  compdef vboxheadless=VBoxHeadless
fi


# Set prompt styling
# Adapted from code found at <https://gist.github.com/1712320>.

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}*%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}*%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}*%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {

  # Compose this value via multiple conditional appends.
  local GIT_STATE=""

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi

}

# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}


# possibly provides access to $#jobstates associative array
# zmodload zsh/parameter

StoppedJobs () {
  local jobCount="$(jobs | wc -l)"
  if [ "$jobCount" = "0" ]; then
    STOPPED_JOBS=""
  elif [ "$jobCount" = "1" ]; then
    STOPPED_JOBS="$jobCount job "
  else
    STOPPED_JOBS="$jobCount jobs "
  fi
}

# Set the right-hand prompt
RPS1='$(git_prompt_string)'

PROMPT='%F{blue}  %(?/─── /── %F{red}!) %F{yellow}$STOPPED_JOBS%F{blue}%c '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  # Ruby build
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi


# Stack for Haskell
export PATH=$HOME/.local/bin:$PATH

export PGDATA="/var/lib/postgres/data"
export PATH=$PATH:$HOME/bin

# Node path
export PATH=$PATH:~/.node_modules/bin
export npm_config_prefix=~/.node_modules

# export NVM_DIR="/home/scallywag/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
