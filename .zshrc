# path
export PATH=$PATH:/opt/homebrew/bin

# alias
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias nvimconf='nvim ~/.config/nvim/init.lua'

eval "$(starship init zsh)"
