set -U fish_greeting
set -gx BROWSER "brave-browser"
set -gx EDITOR "nvim"
set -gx MANPAGER "less -IMRgs --incsearch --use-color -DE+wr -DP+wk -DS+ky -Dd+b -Du+m"
set -gx READER "zathura"
set -gx TERMINAL "alacritty"
set -gx VISUAL "subl"

# One Dark Vivid Color Palette
set -l foreground a0a8b7
set -l selection 535965
set -l comment 7a818e
set -l red e55561
set -l orange cc9057
set -l yellow e2b86b
set -l green 8ebd6b
set -l purple bf68d9
set -l blue 4fa6ed
set -l pink c678dd

set -g fish_color_normal $foreground
set -g fish_color_command $blue
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $blue
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

starship init fish | source

# Set tty colours
if [ "$TERM" = "linux" ]
  printf %b '\e[40m' '\e[8]' # set default background to color 0
  printf %b '\e[37m' '\e[8]' # set default foreground to color 7
  printf %b '\e]P0181b20'    # redefine 'bg'
  printf %b '\e]P87a818e'    # redefine 'comment'
  printf %b '\e]P1e55561'    # redefine 'red'
  printf %b '\e]P9e55561'    # redefine 'bright-red'
  printf %b '\e]P28ebd6b'    # redefine 'green'
  printf %b '\e]PA8ebd6b'    # redefine 'bright-green'
  printf %b '\e]P3cc9057'    # redefine 'brown'
  printf %b '\e]PBe2b86b'    # redefine 'yellow'
  printf %b '\e]P44fa6ed'    # redefine 'blue'
  printf %b '\e]PC4fa6ed'    # redefine 'bright-blue'
  printf %b '\e]P5bf68d9'    # redefine 'magenta'
  printf %b '\e]PDbf68d9'    # redefine 'bright-magenta'
  printf %b '\e]P648b0bd'    # redefine 'cyan'
  printf %b '\e]PE48b0bd'    # redefine 'bright-cyan'
  printf %b '\e]P7a0a8b7'    # redefine 'fg'
  printf %b '\e]PFe6e6e6'    # redefine 'white'
  clear
end

# User specific environment
set PATH $PATH $HOME/.emacs.d/bin:$HOME/.local/bin:$HOME/bin:$HOME/XiaomiADBFastbootTools/platform-tools:

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
        echo -e "\033[0;31m[ex error] => \033[0;33m$argv \033[0mis" \
        "not a valid archive.\n\n\033[0;34mex() \033[0mcan can only" \
        "extract the following archives:\n\t.7z\n\t.bz2\n\t.deb" \
        "\n\t.gz\n\t.rar\n\t.tar\n\t.tar.bz2\n\t.tar.gz\n\t.tar.xz" \
        "\n\t.tar.zst\n\t.tbz2\n\t.tgz\n\t.Z\n\t.zip\n\nRun\033[0;34m" \
        "ex() \033[0musing one of the archives supported.\n"
    end
  else
    echo -e "\033[0;31m[ex error] => \033[0mFile not given." \
      "\n\n\033[0;34mex() \033[0mis an archive extractor. You need to" \
      "add a \033[0;33m<path_to/filename> \033[0mwith one of the" \
      "following extensions:\n\t.7z\n\t.bz2\n\t.deb\n\t.gz\n\t.rar" \
      "\n\t.tar\n\t.tar.bz2\n\t.tar.gz\n\t.tar.xz\n\t.tar.zst\n\t.tbz2" \
      "\n\t.tgz\n\t.Z\n\t.zip\n\ne.g.\033[0;34m ex" \
      "\033[0;33m~/Downloads/compressed.tar.xz\n"
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
alias drmk='doas dnf rm "(dnf repoquery --installonly --latest-limit=-1 -q)" -y'
alias dse='doas dnf se'
alias dup='doas dnf up -y'
alias dwp='doas dnf wp'

alias parm='pacman -Qtdq | doas pacman -Rns --noconfirm -'
alias pcc='doas pacman -Scc --noconfirm'
alias pif='pacman -Si'
alias pin='doas pacman -S --needed'
alias plu='checkupdates'
alias pref='doas pacman -Fy'
alias prm='doas pacman -Rns'
alias pse='pacman -Ss'
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
