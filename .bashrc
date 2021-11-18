#!/usr/bin/env bash

export BROWSER="brave-browser"
export EDITOR="nvim"
export MANPAGER="less -IMRgs --incsearch --use-color -DE+wr -DP+wk -DS+ky -Dd+b -Du+m"
export READER="zathura"
export TERMINAL="alacritty"
export VISUAL="subl"

eval "$(starship init bash)"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.emacs.d/bin:$HOME/.local/bin:$HOME/bin:$HOME/XiaomiADBFastbootTools/platform-tools:" ]]
then
	PATH="$HOME/.emacs.d/bin:$HOME/.local/bin:$HOME/bin:$HOME/XiaomiADBFastbootTools/platform-tools:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

ex () {
	if [ -f "$1" ] ; then
		case "$1" in
			*.7z)     		7z x "$1"        ;;
			*.bz2)    		tar xjf "$1"     ;;
			*.deb)    		ar x "$1"        ;;
			*.gz)     		tar xzf  "$1"    ;;
			*.rar)    		unrar x "$1"     ;;
			*.tar)    		tar xf "$1"      ;;
			*.tar.bz2)		tar xjf "$1"     ;;
			*.tar.gz) 		tar xzf "$1"     ;;
			*.tar.xz) 		tar xJf "$1"     ;;
			*.tar.zst)		unzstd "$1"      ;;
			*.tbz2)   		tar xjf "$1"     ;;
			*.tgz)    		tar xzf "$1"     ;;
			*.Z)      		uncompress "$1"  ;;
			*.zip)    		unzip "$1"       ;;
			*)        		printf -- "\033[0;31m[ex error] => \033[0;33m"$1" \033[0mis not a valid archive.\n\n\033[0;34mex() \033[0mcan can only extract the following archives:\n\t.7z\n\t.bz2\n\t.deb\n\t.gz\n\t.rar\n\t.tar\n\t.tar.bz2\n\t.tar.gz\n\t.tar.xz\n\t.tar.zst\n\t.tbz2\n\t.tgz\n\t.Z\n\t.zip\n\nRun \033[0;34mex() \033[0musing one of the archives supported.\n" ;;
		esac
	else
		printf -- "\033[0;31m[ex error] => \033[0mFile not given.\n\n\033[0;34mex() \033[0mis an archive extractor. You need to add a \033[0;33m<path_to/filename> \033[0mwith one of the following extensions:\n\t.7z\n\t.bz2\n\t.deb\n\t.gz\n\t.rar\n\t.tar\n\t.tar.bz2\n\t.tar.gz\n\t.tar.xz\n\t.tar.zst\n\t.tbz2\n\t.tgz\n\t.Z\n\t.zip\n\ne.g. \033[0;34mex \033[0;33m~/Downloads/compressed.tar.xz\n"
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

# Navigation shortcuts
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# doom emacs
alias ddoctor='doom doctor'
alias dpurge='doom purge'
alias dsync='doom sync'
alias dupgrade='doom upgrade'

# Add some useful flags
alias cp='cp -iv'
alias df='df -h'
alias doas='doas --'
alias free='free -mt'
alias librespot='librespot -n "A315-41" -b 320 -u yourUsername -p yourPassword -c ./cache --enable-volume-normalisation --initial-volume 75 --device-type computer'
alias lynx='lynx -accept_all_cookies'
alias wget='wget -c'

# Merge .Xresources settings
alias merge='xrdb -merge ~/.Xresources'

# Aliases for software managment
alias darm='doas dnf autoremove -y'
alias dcc='doas dnf cc'
alias dif='doas dnf info'
alias din='doas dnf in'
alias dlr='doas dnf lr'
alias dlu='doas dnf lu'
alias dref='doas dnf ref'
alias drm='doas dnf rm'
alias drmk='doas dnf rm $(dnf repoquery --installonly --latest-limit=-1 -q) -y'
alias dse='doas dnf se'
alias dup='doas dnf up -y'
alias dwp='doas dnf wp'

alias parm='pacman -Qtdq | doas pacman -Rns --noconfirm -'
alias pcc='doas pacman -Scc --noconfirm'
alias pif='doas pacman -Si'
alias pin='doas pacman -S --needed'
alias plu='checkupdates'
alias pref='doas pacman -Fy'
alias prm='doas pacman -Rns'
alias pse='doas pacman -Ss'
alias pup='doas pacman -Syu --noconfirm --needed'
alias pwp='pacman -F'

# Update the GRUB config
alias grubup='doas grub2-mkconfig'

# Refresh the fonts cache
alias fontup='doas fc-cache -fv'

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

# nvim/Sublime for important configuration files
alias valacritty='nvim ~/.config/alacritty/alacritty.yml'
alias vbashrc='nvim ~/.bashrc'
alias vdnf='doas nvim /etc/dnf/dnf.conf'
alias vfish='nvim ~/.config/fish/config.fish'
alias vherbstluftwm='nvim ~/.config/herbstluftwm/autostart'
alias vnnvim='nvim ~/.config/nnvim/init.nvim'
alias vpacman='doas nvim /etc/pacman.conf'
alias vpicom='nvim ~/.config/picom/picom.conf'
alias vqtile='nvim ~/.config/qtile/config.py'
alias vspectrwm='nvim ~/.config/spectrwm/spectrwm.conf'
alias vsway='nvim ~/.config/sway/config'
alias vvifm='nvim ~/.config/vifm/vifmrc'

alias salacritty='subl ~/.config/alacritty/alacritty.yml'
alias sbashrc='subl ~/.bashrc'
alias sdnf='doas subl /etc/dnf/dnf.conf'
alias sfish='subl ~/.config/fish/config.fish'
alias sherbstluftwm='subl ~/.config/herbstluftwm/autostart'
alias snnvim='subl ~/.config/nnvim/init.nvim'
alias spacman='doas subl /etc/pacman.conf'
alias spicom='subl ~/.config/picom/picom.conf'
alias sqtile='subl ~/.config/qtile/config.py'
alias sspectrwm='subl ~/.config/spectrwm/spectrwm.conf'
alias ssway='subl ~/.config/sway/config'
alias svifm='subl ~/.config/vifm/vifmrc'

# Git
alias addnew='git add -u'
alias addot='git add .'
alias clone='git clone'
alias commit='git commit -m'
alias pull='git pull'
alias push='git push origin main'

alias config='/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME'
alias cadd='config add'
alias caddnew='config add -uv'
alias ccommit='config commit -m'
alias cpull='config pull'
alias cpush='config push origin main'
alias cstatus='config status'

# Xephyr
alias Xephyr='Xephyr :5 & sleep 1 ; DISPLAY=:5'

# Miscellaneous
alias chogg='find . -type f -name "*.opus" -exec rename .opus .ogg {} +'
alias chopus='find . -type f -name "*.ogg" -exec rename .ogg .opus {} +'

# Options to bash
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s checkwinsize
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s expand_aliases # expand aliases
shopt -s histappend # do not overwrite history
