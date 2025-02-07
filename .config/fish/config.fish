fish_config theme choose "OneDark"
set -U fish_greeting

# starship init fish | source
function fish_prompt
  #set -g __fish_git_prompt_show_informative_status
  set -g __fish_git_prompt_showcolorhints
  set -g __fish_git_prompt_showdirtystate
  set -g __fish_git_prompt_use_informative_chars
  echo -s (set_color --bold blue) (prompt_pwd -d0) \
    (set_color normal) (fish_git_prompt) (set_color green) "  " (set_color normal)
end

# Set tty colours
if [ "$TERM" = "linux" ]
  printf '%b' "\e[40m" "\e[8]" # set default background to color 0
  printf '%b' "\e[37m" "\e[8]" # set default foreground to color 7
  printf '%b' "\e]P0181b20" # redefine "bg"
  printf '%b' "\e]P87a818e" # redefine "comment"
  printf '%b' "\e]P1e55561" # redefine "red"
  printf '%b' "\e]P9e55561" # redefine "bright-red"
  printf '%b' "\e]P28ebd6b" # redefine "green"
  printf '%b' "\e]PA8ebd6b" # redefine "bright-green"
  printf '%b' "\e]P3cc9057" # redefine "brown"
  printf '%b' "\e]PBe2b86b" # redefine "yellow"
  printf '%b' "\e]P44fa6ed" # redefine "blue"
  printf '%b' "\e]PC4fa6ed" # redefine "bright-blue"
  printf '%b' "\e]P5bf68d9" # redefine "magenta"
  printf '%b' "\e]PDbf68d9" # redefine "bright-magenta"
  printf '%b' "\e]P648b0bd" # redefine "cyan"
  printf '%b' "\e]PE48b0bd" # redefine "bright-cyan"
  printf '%b' "\e]P7a0a8b7" # redefine "fg"
  printf '%b' "\e]PFe6e6e6" # redefine "white"
  clear
end

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
  switch $argv
    case "*tar.bz2" "*tbz2" "*tbz"
      tar -xvjf $argv
    case "*tar.gz" "*tgz"
      tar -xvzf $argv
    case "*tar.xz" "*txz" "*tar.lzma"
      tar -xvJf $argv
    case "*tar.zst"
      tar --zstd -xvf $argv
    case "*tar.lrz"
      lrzuntar $argv
    case "*tar"
      tar -xvf $argv
    case "*rar"
      unrar x $argv
    case "*lzh"
      lha x $argv
    case "*7z"
      7z x $argv
    case "*zip" "*jar"
      unzip $argv
    case "*deb"
      ar -x $argv
    case "*bz2"
      bzip2 -d -c $argv
    case "*gz" "*Z"
      gzip -d -c $argv
    case "*xz" "*lzma"
      xz -d -c $argv
    case "*zst"
      zstd -d -c $argv
    case "*lrz"
      lrunzip $argv
    case "*"
      printf '%b\n' "ERROR: '$argv' has unrecognized archive type."
  end
end
# End of functions

# ls command beautified
alias la='eza --group-directories-first -la'
alias ll='eza --group-directories-first -l'
alias lh='eza --group-directories-first -hAl'
alias l='eza --group-directories-first -l'
# alias l.='exa -a | rg "^\."'
# alias la='exa -a --color=always --group-directories-first'
# alias ll='exa -l --color=always --group-directories-first'
# alias ls='exa -al --color=always --group-directories-first'
# alias lt='exa -aT --color=always --group-directories-first'

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
alias lynx='lynx -accept_all_cookies'
alias wget='wget -c'

# Merge .Xresources settings
alias merge='xrdb -merge $XDG_CONFIG_HOME/X11/xresources'

# Aliases for software managment
alias darm='doas dnf autoremove -y'
alias dcc='doas dnf cc'
alias dif='doas dnf info'
alias din='doas dnf in'
alias dlr='doas dnf lr'
alias dlu='doas dnf lu'
alias dref='doas dnf ref'
alias drm='doas dnf rm'
alias drmk='doas dnf rm (dnf repoquery --installonly --latest-limit=-1 -q) -y'
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
alias valacritty='nvim $XDG_CONFIG_HOME/alacritty/alacritty.yml'
alias vbashrc='nvim $HOME/.bashrc'
alias vdnf='doas nvim /etc/dnf/dnf.conf'
alias vfish='nvim $XDG_CONFIG_HOME/fish/config.fish'
alias vherbstluftwm='nvim $XDG_CONFIG_HOME/herbstluftwm/autostart'
alias vnnvim='nvim $XDG_CONFIG_HOME/nvim/init.lua'
alias vpacman='doas nvim /etc/pacman.conf'
alias vpicom='nvim $XDG_CONFIG_HOME/picom/picom.conf'
alias vqtile='nvim $XDG_CONFIG_HOME/qtile/config.py'
alias vspectrwm='nvim $XDG_CONFIG_HOME/spectrwm/spectrwm.conf'
alias vsway='nvim $XDG_CONFIG_HOME/sway/config'
alias vvifm='nvim $XDG_CONFIG_HOME/vifm/vifmrc'

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
