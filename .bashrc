# .bashrc

export BROWSER="brave-browser"
export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export READER="zathura"
export TERMINAL="alacritty"
export VISUAL="subl"

eval "$(starship init bash)"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.emacs.d/bin${PATH:+:${PATH}}"
PATH="$HOME/.local/bin${PATH:+:${PATH}}"
PATH="$HOME/XiaomiADBFastbootTools/platform-tools${PATH:+:${PATH}}"
PATH="/usr/local/go/bin${PATH:+:${PATH}}"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

ex ()
{
	if [ -f $1 ] ; then
		case $1 in
			*.7z)     		7z x $1        ;;
			*.bz2)    		tar xjf $1     ;;
			*.deb)    		ar x $1        ;;
			*.gz)     		tar xzf  $1      ;;
			*.rar)    		unrar x $1     ;;
			*.tar)    		tar xf $1      ;;
			*.tar.bz2)		tar xjf $1     ;;
			*.tar.gz) 		tar xzf $1     ;;
			*.tar.xz) 		tar xJf $1      ;;
			*.tar.zst)		unzstd $1      ;;
			*.tbz2)   		tar xjf $1     ;;
			*.tgz)    		tar xzf $1     ;;
			*.Z)      		uncompress $1  ;;
			*.zip)    		unzip $1       ;;
			*)        		echo "'$1' cannot be extracted via ex()" ;;
		esac
		else
		echo "'$1' is not a valid file"
	fi
}

# Ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# ls command beautified
alias l.='exa -a | rg "^\."'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias ls='exa -al --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'

# Fix obvious typo's
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias pdw='pwd'

# vim, doom emacs and bat
alias cat='bat'
alias ddoctor='doom doctor'
alias dpurge='doom purge'
alias dsync='doom sync'
alias dupgrade='doom upgrade'
alias vi='vim'
alias vim='nvim'

# Add some useful flags
alias cp='cp -i'
alias df='df -h'
alias efd='fd -F'
alias fd='fd -Hi'
alias free='free -mt'
alias librespot='librespot -n "A315-41" -b 320 -u yourUsername -p yourPassword -c ./cache --enable-volume-normalisation --initial-volume 75 --device-type computer'
alias lynx='lynx -accept_all_cookies'
alias wget='wget -c'

# List the groups of the user
alias userlist='cut -d: -f1 /etc/passwd'

# Merge .Xresources settings
alias merge='xrdb -merge ~/.Xresources'

# Aliases for software managment
alias darm='sudo dnf autoremove -y'
alias dcc='dnf cc'
alias dif='dnf info'
alias din='sudo dnf in'
alias dlr='dnf lr'
alias dlu='dnf lu'
alias dref='dnf ref'
alias drm='sudo dnf rm'
alias drmk='sudo dnf rm $(dnf repoquery --installonly --latest-limit=-1 -q) -y'
alias dse='dnf se'
alias dup='sudo dnf up -y'
alias dwp='dnf wp'

alias parm='pacman -Qtdq | sudo pacman -Rns --noconfirm -'
alias pcc='paru -Scc --noconfirm'
alias pif='paru -Si'
alias pin='paru -S --needed'
alias plu='pacman -Qqu'
alias pref='sudo pacman -Fy'
alias prm='paru -Rns'
alias pse='paru -Ss'
alias pup='sudo pacman -Syu --noconfirm --needed'
alias paup='paru -Sua --noconfirm --needed'
alias pwp='pacman -F'

# Update the GRUB config
alias grubup='sudo grub2-mkconfig'

# Refresh the fonts cache
alias fontup='sudo fc-cache -fv'

# Check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# youtube-dl
alias yta-aac='youtube-dl --extract-audio --audio-format aac'
alias yta-best='youtube-dl --extract-audio --audio-format best'
alias yta-flac='youtube-dl --extract-audio --audio-format flac'
alias yta-m4a='youtube-dl --extract-audio --audio-format m4a'
alias yta-mp3='youtube-dl --extract-audio --audio-format mp3'
alias yta-opus='youtube-dl --extract-audio --audio-format opus'
alias yta-vorbis='youtube-dl --extract-audio --audio-format vorbis'
alias yta-wav='youtube-dl --extract-audio --audio-format wav'
alias ytv-best='youtube-dl -f bestvideo+bestaudio'

# Vim/Sublime for important configuration files
alias valacritty='vim ~/.config/alacritty/alacritty.yml'
alias vbashrc='vim ~/.bashrc'
alias vdnf='sudo vim /etc/dnf/dnf.conf'
alias vfish='vim ~/.config/fish/config.fish'
alias vherbstluftwm='vim ~/.config/herbstluftwm/autostart'
alias vnvim='vim ~/.config/nvim/init.vim'
alias vpicom='vim ~/.config/picom/picom.conf'
alias vqtile='vim ~/.config/qtile/config.py'
alias vspectrwm='vim ~/.config/spectrwm/spectrwm.conf'
alias vvim='vim ~/.vimrc'

alias salacritty='subl ~/.config/alacritty/alacritty.yml'
alias sbashrc='subl ~/.bashrc'
alias sdnf='sudo subl /etc/dnf/dnf.conf'
alias sfish='subl ~/.config/fish/config.fish'
alias sherbstluftwm='subl ~/.config/herbstluftwm/autostart'
alias snvim='subl ~/.config/nvim/init.vim'
alias spicom='subl ~/.config/picom/picom.conf'
alias sqtile='subl ~/.config/qtile/config.py'
alias sspectrwm='subl ~/.config/spectrwm/spectrwm.conf'
alias svim='subl ~/.vimrc'

# Git
alias addot='git add .'
alias clone='git clone'
alias commit='git commit -m'
alias pull='git pull'
alias push='git push origin main'

alias config='/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME'
alias cadd='config add'
alias ccommit='config commit -m'
alias cpull='config pull'
alias cpush='config push origin main'
alias cstatus='config status'

# Xephyr
alias Xephyr='Xephyr :5 & sleep 1 ; DISPLAY=:5'

# GPG
	# Verify signature for isos
alias gpg-check='gpg2 --keyserver-options auto-key-retrieve --verify'
	# Receive the key of a developer
alias gpg-retrieve='gpg2 --keyserver-options auto-key-retrieve --receive-keys'

# Shutdown or reboot
alias pwrbt='systemctl reboot'
alias pwroff='systemctl poweroff'

# Miscellaneous
alias chogg='find . -type f -name "*.opus" -exec rename .opus .ogg \{\} \;'
alias chopus='find . -type f -name "*.ogg" -exec rename .ogg .opus \{\} \;'

# shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s expand_aliases # expand aliases
shopt -s histappend # do not overwrite history