# path
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$HOME/.cargo/bin

# alias
alias ls='ls -l --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias nvimconf='nvim ~/.config/nvim/init.lua'

alias dotfiles='cd ~/git/dotfiles'
alias tedvit='cd ~/lab/vs-tedvit'

eval "$(starship init zsh)"
