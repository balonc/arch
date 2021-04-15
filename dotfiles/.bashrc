# ~/.bashrc
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
#033[38;5;15m\]]\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
export PS1="\[$(tput bold)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;11m\]\W\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

eval $(dircolors ~/.dircolors)

# visual and aesthetics aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias grep='grep --color=auto'
alias ifconfig='grc ifconfig'
alias ps='grc ps'
alias netstat='grc netstat'
alias tail='grc tail'
alias pacman='sudo pacman --color always'

# hardware aliases
alias backlight+='brightnessctl --device=intel_backlight set +5%'
alias backlight-='brightnessctl --device=intel_backlight set 5%-'

# functional aliases
alias home='cd ~'
alias e='emacs -nw'
alias nano='emacs -nw'
alias feh='feh -Z'

# others aliases
# alias desmume='desmume --fwlang=5'
alias gameboy='visualboyadvance-m'
alias telegram='./Documentos/Code/Telegram/Telegram'

