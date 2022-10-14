export PATH=/bin:/sbin:/usr/bin:/usr/sbin

export BROWSER=brave-browser
export EDITOR=nvim
export MANPAGER="less -IMRgs --incsearch --use-color -DE+wr -DP+wk -DS+ky -Dd+b -Du+m"
export READER=zathura
export TERMINAL=alacritty
export VISUAL=geany

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

export ANDROID_HOME="$XDG_DATA_HOME"/android
export GOPATH="$XDG_DATA_HOME"/go
export JULIA_DEPOT_PATH="$XDG_DATA_HOME"/julia:"$JULIA_DEPOT_PATH"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export KDEHOME="$XDG_CONFIG_HOME"/kde
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export RXVT_SOCKET="$XDG_RUNTIME_DIR"/urxvtd
export SSB_HOME="$XDG_DATA_HOME"/zoom
export TEXMFCONFIG="$XDG_CONFIG_HOME"/texlive/texmf-config
export TEXMFHOME="$XDG_DATA_HOME"/texmf
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
