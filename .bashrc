#bash kleurtjes
txtblk="\e[0;30m" # Black - Regular
txtred="\e[0;31m" # Red
txtgrn="\e[0;32m" # Green
txtylw="\e[0;33m" # Yellow
txtblu="\e[0;34m" # Blue
txtpur="\e[0;35m" # Purple
txtcyn="\e[0;36m" # Cyan
txtwht="\e[0;37m" # White
bldblk="\e[1;30m" # Black - Bold
bldred="\e[1;31m" # Red
bldgrn="\e[1;32m" # Green
bldylw="\e[1;33m" # Yellow
bldblu="\e[1;34m" # Blue
bldpur="\e[1;35m" # Purple
bldcyn="\e[1;36m" # Cyan
bldwht="\e[1;37m" # White
unkblk="\e[4;30m" # Black - Underline
undred="\e[4;31m" # Red
undgrn="\e[4;32m" # Green
undylw="\e[4;33m" # Yellow
undblu="\e[4;34m" # Blue
undpur="\e[4;35m" # Purple
undcyn="\e[4;36m" # Cyan
undwht="\e[4;37m" # White
bakblk="\e[40m"   # Black - Background
bakred="\e[41m"   # Red
bakgrn="\e[42m"   # Green
bakylw="\e[43m"   # Yellow
bakblu="\e[44m"   # Blue
bakpur="\e[45m"   # Purple
bakcyn="\e[46m"   # Cyan
bakwht="\e[47m"   # White
txtrst="\e[0m"    # Text Reset

# git info in prompt
find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch=" ($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty=' *'
  else
    git_dirty=''
  fi
}

check_jobs() {
  jobs_count=$(jobs -p)
}

export PROMPT_COMMAND="find_git_branch; find_git_dirty; check_jobs;"

export PS1="$bldblu""DIKMACHINE ===> $bldpur\w$bldwht"'$(if [[ "$git_dirty" != "" ]]; then echo -e "$txtred"; else echo -e "$txtgrn"; fi)$git_branch$git_dirty $(if [[ "$jobs_count" != "" ]]; then echo -e "$bldylw""JOBS! "; fi)'"$txtwht\$ "

HISTSIZE= HISTFILESIZE=
# TMUX

if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

alias py='python3'

# CUDA
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64
