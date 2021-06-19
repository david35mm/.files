set fish_greeting
set -gx BROWSER "brave-browser"
set -gx EDITOR "nvim"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT "-c"
set -gx READER "zathura"
set -gx TERMINAL "alacritty"
set -gx VISUAL "subl"

starship init fish | source

# User specific environment
set PATH $PATH $HOME/.emacs.d/bin:$HOME/.local/bin:$HOME/bin:$HOME/XiaomiADBFastbootTools/platform-tools:/usr/local/go/bin:

# Start of user functions

# Functions needed for !! and !$
function __history_previous_command
	switch (commandline -t)
	case "!"
		commandline -t $history[1]; commandline -f repaint
	case "*"
		commandline -i !
	end
end

function __history_previous_command_arguments
	switch (commandline -t)
	case "!"
		commandline -t ""
		commandline -f history-token-search-backward
	case "*"
		commandline -i '$'
	end
end

# The bindings for !! and !$
bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# Function for extracting archives
function ex
	set ext 7z bz2 deb gz rar tar tar.bz2 tar.gz tar.xz tar.zst tbz2 tgz Z zip
	if test -f "$argv"
		switch $argv
			case "*.$ext[1]"
				7z x ./$argv
			case "*.$ext[2]"
				tar xjf ./$argv
			case "*.$ext[3]"
				ar x ./$argv
			case "*.$ext[4]"
				tar xzf ./$argv
			case "*.$ext[5]"
				unrar x ./$argv
			case "*.$ext[6]"
				tar xf ./$argv
			case "*.$ext[7]"
				tar xjf ./$argv
			case "*.$ext[8]"
				tar xzf ./$argv
			case "*.$ext[9]"
				tar xJf ./$argv
			case "*.$ext[10]"
				unzstd ./$argv
			case "*.$ext[11]"
				tar xjf ./$argv
			case "*.$ext[12]"
				tar xzf ./$argv
			case "*.$ext[13]"
				uncompress ./$argv
			case "*.$ext[14]"
				unzip ./$argv
			case '*'
				printf -- "\033[0;31m[ex error] => \033[0;33m$argv \033[0mis not a valid archive.\n\n\033[0;34mex() \033[0mcan can only extract the following archives:\n\t.7z\n\t.bz2\n\t.deb\n\t.gz\n\t.rar\n\t.tar\n\t.tar.bz2\n\t.tar.gz\n\t.tar.xz\n\t.tar.zst\n\t.tbz2\n\t.tgz\n\t.Z\n\t.zip\n\nRun \033[0;34mex() \033[0musing one of the archives supported.\n"
		end
	else
		printf -- "\033[0;31m[ex error] => \033[0mFile not given.\n\n\033[0;34mex() \033[0mis an archive extractor. You need to add a \033[0;33m<path_to/filename> \033[0mwith one of the following extensions:\n\t.7z\n\t.bz2\n\t.deb\n\t.gz\n\t.rar\n\t.tar\n\t.tar.bz2\n\t.tar.gz\n\t.tar.xz\n\t.tar.zst\n\t.tbz2\n\t.tgz\n\t.Z\n\t.zip\n\ne.g. \033[0;34mex \033[0;33m~/Downloads/compressed.tar.xz\n"
	end
end
# End of functions

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

# vim, doom emacs and bat
alias cat='bat --theme OneHalfDark'
alias ddoctor='doom doctor'
alias dpurge='doom purge'
alias dsync='doom sync'
alias dupgrade='doom upgrade'
alias vim='nvim'

# Add some useful flags
alias cp='cp -iv'
alias df='df -h'
alias efd='fd -F'
alias fd='fd -Hi'
alias free='free -mt'
alias librespot='librespot -n "A315-41" -b 320 -u yourUsername -p yourPassword -c ./cache --enable-volume-normalisation --initial-volume 75 --device-type computer'
alias lynx='lynx -accept_all_cookies'
alias wget='wget -c'

# Merge .Xresources settings
alias merge='xrdb -merge ~/.Xresources'

# Aliases for software managment
alias darm='sudo dnf autoremove -y'
alias dcc='sudo dnf cc'
alias dif='sudo dnf info'
alias din='sudo dnf in'
alias dlr='sudo dnf lr'
alias dlu='sudo dnf lu'
alias dref='sudo dnf ref'
alias drm='sudo dnf rm'
alias drmk='sudo dnf rm (dnf repoquery --installonly --latest-limit=-1 -q) -y'
alias dse='sudo dnf se'
alias dup='sudo dnf up -y'
alias dwp='sudo dnf wp'

alias parm='pacman -Qtdq | sudo pacman -Rns --noconfirm -'
alias pcc='paru -Scc --noconfirm'
alias pif='paru -Si'
alias pin='paru -S --needed'
alias plu='checkupdates'
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
alias vpacman='sudo vim /etc/pacman.conf'
alias vparu='vim ~/.config/paru/paru.conf'
alias vpicom='vim ~/.config/picom/picom.conf'
alias vqtile='vim ~/.config/qtile/config.py'
alias vspectrwm='vim ~/.config/spectrwm/spectrwm.conf'
alias vsway='vim ~/.config/sway/config'
alias vvifm='vim ~/.config/vifm/vifmrc'

alias salacritty='subl ~/.config/alacritty/alacritty.yml'
alias sbashrc='subl ~/.bashrc'
alias sdnf='sudo subl /etc/dnf/dnf.conf'
alias sfish='subl ~/.config/fish/config.fish'
alias sherbstluftwm='subl ~/.config/herbstluftwm/autostart'
alias snvim='subl ~/.config/nvim/init.vim'
alias spacman='sudo subl /etc/pacman.conf'
alias sparu='subl ~/.config/paru/paru.conf'
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

# Shutdown or reboot
alias pwrbt='systemctl reboot'
alias pwroff='systemctl poweroff'

# Miscellaneous
alias chogg='find . -type f -name "*.opus" -exec rename .opus .ogg \{\} \;'
alias chopus='find . -type f -name "*.ogg" -exec rename .ogg .opus \{\} \;'
