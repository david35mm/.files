# config.fish

set fish_greeting
set -gx BROWSER "brave-browser"
set -gx EDITOR "nvim"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT "-c"
set -gx TERMINAL "alacritty"
set -gx VISUAL "subl"

starship init fish | source

# User specific environment
set PATH $PATH /usr/local/go/bin:$HOME/.emacs.d/bin:$HOME/.local/bin:$HOME/XiaomiADBFastbootTools/platform-tools


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
if [ $fish_key_bindings = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for extracting archives
function ex
	set ext zip rar bz2 gz tar tbz2 tgz Z 7z xz exe tar.bz2 tar.gz tar.xz lzma
	if test -z "$argv"
    	# display usage if no parameters given
    	echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|lzma>"
	else
		if test -f "$argv"
			switch $argv
				case "*.$ext[1]"		
					unzip ./$argv
				case "*.$ext[2]"		
					unrar x -ad ./$argv
				case "*.$ext[5]"		
					tar xvf ./$argv
				case "*.$ext[6]"		
					tar xvjf ./$argv
				case "*.$ext[7]"		
					tar xvzf ./$argv
				case "*.$ext[8]"		
					uncompress ./$argv
				case "*.$ext[9]"		
					7z x ./$argv
				case "*.$ext[11]"		
					cabextract ./$argv
				case "*.$ext[12]"		
					tar xvjf ./$argv
				case "*.$ext[3]"		
					bunzip2 ./$argv
				case "*.$ext[13]"		
					tar xvzf ./$argv
				case "*.$ext[4]"		
					gunzip ./$argv
				case "*.$ext[14]"		
					tar xvJf ./$argv
				case "*.$ext[10]"		
					unxz ./$argv
				case "*.$ext[15]"		
					unlzma ./$argv
				case '*'				
					echo "extract: $argv - unknown archive method"
			end
		else
			echo $argv "- file does not exist"
		end
	end
end
# End of functions

# ls command beautified
alias l.='exa -a | egrep "^\."'
alias la='exa -a --color=always --group-directories-first'
alias ll='exa -l --color=always --group-directories-first'
alias ls='exa -al --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'

# Fix obvious typo's
alias cd..='cd ..'
alias pdw='pwd'

# Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# vim, doom emacs and bat
alias cat='bat'
alias ddoctor='doom doctor'
alias dpurge='doom purge'
alias dsync='doom sync'
alias dupgrade='doom upgrade'
alias find='fd'
alias vi='vim'
alias vim='nvim'

# Add some useful flags
alias cp='cp -i'
alias df='df -h'
alias free='free -mt'
alias librespot='librespot -n "A315-41" -b 320 -u d.geek -p j3RR6#yJq8Es -c ./cache --enable-volume-normalisation --initial-volume 75 --device-type computer'
alias lynx='lynx -accept_all_cookies'
alias wget='wget -c'

# List the groups of the user
alias userlist='cut -d: -f1 /etc/passwd'

# Merge .Xresources settings
alias merge='xrdb -merge ~/.Xresources'

# Aliases for software managment
alias darm='sudo dnf autoremove -y'
alias dcln='dnf clean'
alias dif='dnf info'
alias din='sudo dnf in'
alias dlr='dnf lr'
alias dlu='dnf lu'
alias dref='dnf ref'
alias drm='sudo dnf rm'
alias drmk='sudo dnf rm (dnf repoquery --installonly --latest-limit=-1 -q) -y'
alias dse='dnf se'
alias dup='sudo dnf up -y'
alias dwp='dnf provides'

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

# Vim for important configuration files
alias valacritty='vim ~/.config/alacritty/alacritty.yml'
alias vbashrc='vim ~/.bashrc'
alias vdnf='sudo vim /etc/dnf/dnf.conf'
alias vherbstluftwm='vim ~/.config/herbstluftwm/autostart'
alias vnvim='vim ~/.config/nvim/init.vim'
alias vpicom='vim ~/.config/picom/picom.conf'
alias vqtile='vim ~/.config/qtile/config.py'
alias vspectrwm='vim ~/.config/spectrwm/spectrwm.conf'
alias vvim='vim ~/.vimrc'

# Git
alias addot='git add .'
alias commit='git commit -m'
alias pull='git pull'
alias push='git push'

alias config='/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME'
alias cadd='config add'
alias ccommit='config commit -m'
alias cpull='config pull'
alias cpush='config push'
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
