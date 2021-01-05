# .bashrc

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave-browser"
export MANPAGER="nvim +Man!"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin${PATH:+:${PATH}}"
PATH="$HOME/XiaomiADBFastbootTools/platform-tools${PATH:+:${PATH}}"
PATH="$HOME/.emacs.d/bin${PATH:+:${PATH}}"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

eval "$(starship init bash)"

# User specific aliases and functions

ex ()
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1   ;;
			*.tar.gz)    tar xzf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       unrar x $1   ;;
			*.gz)        gunzip $1    ;;
			*.tar)       tar xf $1    ;;
			*.tbz2)      tar xjf $1   ;;
			*.tgz)       tar xzf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1;;
			*.7z)        7z x $1      ;;
			*.deb)       ar x $1      ;;
			*.tar.xz)    tar xf $1    ;;
			*.tar.zst)   unzstd $1    ;;
			*)           echo "'$1' cannot be extracted via ex()" ;;
		esac
		else
		echo "'$1' is not a valid file"
	fi
}

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#list
alias ls='exa -al --color=always --group-directories-first'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'
alias l='ls'

#fix obvious typo's
alias cd..='cd ..'
alias pdw='pwd'
alias udpate='sudo dnf -y update'
alias upate='sudo dnf -y update'


## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#some flags
alias vi='vim'
alias vim='nvim'
alias wget='wget -c'
alias cp='cp -i'
alias df='df -h'
alias free='free -mt'
alias lynx='lynx -accept_all_cookies'
alias librespot='librespot -n "A315-41" -b 320 -u yourUsername -p yourPassword -c ./cache --enable-volume-normalisation --initial-volume 75 --device-type computer'

#userlist
alias userlist='cut -d: -f1 /etc/passwd'

#merge new settings
alias merge='xrdb -merge ~/.Xresources'

# Aliases for software managment
#alias dnf='sudo dnf'
#alias update='sudo dnf -y update'
alias autorm='sudo dnf -y autoremove'
alias rmcache='sudo dnf clean all'
alias mkcache='sudo dnf makecache'
alias rmkernel='dnf rm $(dnf repoquery --installonly --latest-limit=-1 -q)'

#ps
alias psa='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'

#grub update
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

#add new fonts
alias update-fc='sudo fc-cache -fv'

#switch between bash and zsh
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

#hardware info --short
alias hw='hwinfo --short'

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

#youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

#get the error messages from journalctl
alias jctl='journalctl -p 3 -xb'

#vim for important configuration files
alias vqtile='vim ~/.config/qtile/config.py'
alias vdnf='sudo vim /etc/dnf/dnf.conf'
alias vpicom='vim ~/.config/picom/picom.conf'
alias valacritty='vim ~/.config/alacritty/alacritty.yml'
alias vbashrc='vim ~/.bashrc'
alias vvim='vim ~/.vimrc'
alias vspectrwm='vim ~/.config/spectrwm/spectrwm.conf'
alias vherbstluftwm='vim ~/.config/herbstluftwm/autostart'

#git
alias addot='git add .'
alias commit='git commit -m'
alias push='git push'
alias pull='git pull'
alias config='/usr/bin/git --git-dir=/home/david35mm/.files/ --work-tree=/home/david35mm'
alias cadd='config add'
alias ccommit='config commit -m'
alias cpush='config push'
alias cpull='config pull'
alias cstatus='config status'

#Xephyr
alias Xephyr='Xephyr :5 & sleep 1 ; DISPLAY=:5'

#gpg
#verify signature for isos
alias gpg-check='gpg2 --keyserver-options auto-key-retrieve --verify'
#receive the key of a developer
alias gpg-retrieve='gpg2 --keyserver-options auto-key-retrieve --receive-keys'

#shutdown or reboot
alias pwroff='systemctl poweroff'
alias pwrbt='systemctl reboot'

#miscellaneous
alias chogg='find . -type f -name "*.opus" -exec rename .opus .ogg \{\} \;'
alias chopus='find . -type f -name "*.ogg" -exec rename .ogg .opus \{\} \;'

#bluetooth control
alias blt='bluetoothctl power on & bluetoothctl connect 5C:EB:68:7E:12:7B'
alias noblt='bluetoothctl power off'
