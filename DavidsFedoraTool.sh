#!/bin/sh

showWelcome() {
	clear
	echo "==================================================="
	echo "=                                                 ="
	printf -- "=     Welcome to \033[3mDavid Salomon's \033[0;36mFedora\033[0m tool      =\n"
	echo "=                                                 ="
	echo "=     Version 6                                   ="
	echo "=                                                 ="
	echo "=     Brought to you by david35mm                 ="
	echo "=     https://github.com/david35mm/.files         ="
	echo "=                                                 ="
	printf -- "===================================================\n"
	sleep 4
}
#
#
showMainMenu() { while true
do
	clear
	echo "-------------------------------------"
	printf -- " \033[3mDavid Salomon's \033[0;36mFedora\033[0m Tool\n"
	printf -- "-------------------------------------\n\n"
	echo "  1) Configure DNF with better settings"
	echo "  2) Install the X11 Display Server"
	printf -- "  3) Clone \033[3mDavid's\033[0m GitHub repository\n"
	echo "  4) Install window managers and some utilities"
	echo "  5) Install software collection"
	printf -- "  6) \033[1;30mB\033[0;33me\033[0;31ma\033[0;36mu\033[1;33mt\033[0;32mi\033[0;34mf\033[0;35my\033[0;37m!\033[0m\n"
	printf -- "  7) Delete unnecessary remaining files \033[1m(Make sure this is the last you do)\033[0m\n\n"
	printf -- "  X) Exit\n\n"
	printf "Enter your choice: "
	read -r choice </dev/tty
	case $choice in
		1 ) confDNF ;;
		2 ) getXorg ;;
		3 ) showGitMenu ;;
		4 ) showWMInstMenu ;;
		5 ) showSoftInstMenu ;;
		6 ) getPretty ;;
		7 ) purgeLeftOvers ;;
		x|X ) exit ;;
		* ) invalid ;;
	esac
done
}
#
#
showGitMenu() { while true
do
	clear
	echo "----------------------------------"
	printf -- " Clone \033[3mDavid's\033[0m GitHub repository\n"
	printf -- "----------------------------------\n\n"
	echo "  1) Install Git"
	printf -- "  2) Clone the repo (with the --bare flag)\n\n"
	printf -- "  R) Return to menu\n\n"
	printf -- "  \033[1mDISCLAIMER:\033[0m Be aware that by cloning the repo some important files in your \033[0;34m\033[4m\"\$HOME\"\033[0m folder are going to be renamed (as a backup)\n\n"
	printf "Please enter your choice: "
	read -r choice </dev/tty
	case $choice in
		1 ) getGit;;
		2 ) getRepo ;;
		r|R ) showMainMenu ;;
		* ) invalid ;;
	esac
done
}
#
#
showWMInstMenu() { while true
do
	clear
	echo "---------------------------------------------"
	echo " Install window managers and some utilities"
	printf -- "---------------------------------------------\n\n"
	echo "  1) Install Qtile"
	echo "  2) Install Spectrwm"
	echo "  3) Install Herbstluftwm"
	echo "  4) Install utils (picom, dunst, nitrogen, etc)"
	echo "  5) Install some extra utils (Bluetooth, MTP support, pavucontrol, Polybar, etc)"
	printf -- "  6) Install fonts, themes, icons & wallpapers\n\n"
	printf -- "  R) Return to menu\n\n"
	printf "Please enter your choice: "
	read -r choice </dev/tty
	case $choice in
		1 ) getQtile ;;
		2 ) getSpectrwm ;;
		3 ) getHerbstluft ;;
		4 ) getUtils ;;
		5 ) getUtilsExtra ;;
		6 ) getThemesIcons ;;
		r|R ) showMainMenu ;;
		* ) invalid ;;
	esac
done
}
#
#
showSoftInstMenu() {
	while true
do
	clear
	echo "--------------------------------"
	echo " Install software collection"
	printf -- "--------------------------------\n\n"
	printf -- "This section will install the following software:\nBrowser (Brave), file manager (pcmanfm), multimedia (Celluloid, Geeqie & cmus)\nPDF reader (Zathura), office suite (OnlyOffice), text editor (Sublime Text)\n\nInstall all at once? (y/N)\n\n"
	printf -- "  R) Return to menu\n\n"
	printf "Please enter your choice: "
	read -r choice </dev/tty
	case $choice in
		y|Y ) getAllSoft ;;
		n|N ) showMainMenu ;;
		r|R ) showMainMenu ;;
		* ) invalid ;;
	esac
done
}
#
#
getXorg(){
	clear
	echo "Downloading the X11 Display Server and lightdm"
	sudo dnf in xorg-x11-server-Xorg lightdm-gtk -y
	sleep 2
	clear
	echo "Changing the default systemd target to 'graphical'"
	sudo systemctl set-default graphical.target
	sleep 2
}
#
#
getGit() {
	clear
	echo "Installing Git"
	sudo dnf in git-core -y
	sleep 2
}
#
#
getRepo() {
	clear
	printf -- "This script will create backups of the following files and folders \033[1;33m(if they exist)\033[0m:\n.bashrc\n.config/\n.files/\n.gitignore\n.Xresources\nDavidsArchTool.sh\nDavidsFedoraTool.sh\nREADME.md\n\n\tThe backup files will have a \033[0;34m\033[4m.bak\033[0m extension\n\n"
	sleep 4
	[ -e .bashrc ] && mv -v .bashrc .bashrc.bak
	[ -e .config ] && mv -v .config/ .config.bak/
	[ -e .files ] && mv -v .files/ .files.bak/
	[ -e .gitignore ] && mv -v .gitignore .gitignore.bak
	[ -e .Xresources ] && mv -v .Xresources .Xresources.bak
	[ -e DavidsArchTool.sh ] && mv -v DavidsArchTool.sh DavidsArchTool.sh.bak
	[ -e DavidsFedoraTool.sh ] && mv -v DavidsFedoraTool.sh DavidsFedoraTool.sh.bak
	[ -e README.md ] && mv -v README.md README.md.bak
	clear
	git clone --bare https://github.com/david35mm/.files.git "$HOME"/.files && /usr/bin/git --git-dir="$HOME"/.files/ --work-tree="$HOME" checkout && /usr/bin/git --git-dir="$HOME"/.files/ --work-tree="$HOME" config --local status.showUntrackedFiles no && sleep 4 && clear && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m All the files were written successfully at your \033[0;34m\033[0;4m\"\$HOME\"\033[0m folder" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m The repo files could not be written at your \033[0;34m\033[4m\"\$HOME\"\033[0m folder"
	sleep 2
}
#
#
confDNF() {
	clear
	printf -- "Type your password to write better settings at \033[0;34m\033[4m/etc/dnf/dnf.conf\033[0m\n"
	printf -- "[main]\nbest=True\ncheck_config_file_age=False\nclean_requirements_on_remove=True\ncolor=always\ndefaultyes=True\ndeltarpm=True\ndiskspacecheck=False\nfastestmirror=True\ngpgcheck=True\ninstall_weak_deps=False\ninstallonly_limit=2\nkeepcache=False\nmax_parallel_downloads=10\nmetadata_expire=259200\nmetadata_timer_sync=0\nobsoletes=True\nprotect_running_kernel=False\nskip_if_unavailable=True\nthrottle=0\nzchunk=True" | sudo tee /etc/dnf/dnf.conf && clear && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m Settings written at \033[0;34m\033[4m/etc/dnf/dnf.conf\033[0m" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m The settings could not be written at \033[0;34m\033[4m/etc/dnf/dnf.conf\033[0m"
	sleep 2
	clear
	echo "Creating common aliases for DNF"
	sudo dnf alias add cc='\clean all'
	sudo dnf alias add if='info'
	sudo dnf alias add in='install'
	sudo dnf alias add lr='repolist'
	sudo dnf alias add lu='list updates'
	sudo dnf alias add ref='makecache'
	sudo dnf alias add rm='remove'
	sudo dnf alias add se='search'
	sudo dnf alias add up='upgrade'
	sudo dnf alias add wp='provides'
	sleep 2
}
#
#
getQtile() {
	clear
	echo "Adding david35mm's RPM repo"
	sudo dnf config-manager --add-repo https://raw.githubusercontent.com/david35mm/david35mm-rpm/main/
	sudo rpm --import https://raw.githubusercontent.com/david35mm/david35mm-rpm/main/gpg/RPM-GPG-KEY-dsalomon
	echo "Downloading Qtile"
	sudo dnf in qtile -y
	sleep 2
}
#
#
getSpectrwm() {
	clear
	echo "Downloading Spectrwm"
	sudo dnf in spectrwm -y
	sleep 2
}
#
#
getHerbstluft() {
	clear
	echo "Adding david35mm's RPM repo"
	sudo dnf config-manager --add-repo https://raw.githubusercontent.com/david35mm/david35mm-rpm/main/
	sudo rpm --import https://raw.githubusercontent.com/david35mm/david35mm-rpm/main/gpg/RPM-GPG-KEY-dsalomon
	echo "Downloading Herbstluftwm"
	sudo dnf in herbstluftwm -y
	sleep 2
}
#
#
getUtils() {
	clear
	echo "Adding david35mm's RPM repo"
	sudo dnf config-manager --add-repo https://raw.githubusercontent.com/david35mm/david35mm-rpm/main/
	sudo rpm --import https://raw.githubusercontent.com/david35mm/david35mm-rpm/main/gpg/RPM-GPG-KEY-dsalomon
	echo "Installing utilities"
	sudo dnf in alacritty alsa-utils bat brightnessctl dunst exa fd fish libnotify lxappearance lxpolkit neovim nitrogen ntfs-3g picom pipewire-alsa pipewire-plugin-jack pipewire-pulseaudio pulseaudio-utils rofi udiskie ytop -y
	sleep 2
}
#
#
getUtilsExtra() {
	clear
	echo "Installing extra utilities"
	sudo dnf in arandr blueman gvfs gvfs-fuse gvfs-mtp libmtp maim nm-connection-editor pavucontrol polybar -y
	sleep 2
}
#
#
getThemesIcons() {
	clear
	sudo dnf in tar -y
	[ -e fonts-themes ] && rm -rf fonts-themes/
	git clone https://github.com/david35mm/fonts-themes.git
	printf -- "Extracting fonts, themes and icons to the \033[0;34m\033[4m/usr/share/\033[0m folder\n"
	[ -e /usr/share/fonts ] || sudo mkdir -v /usr/share/fonts
	[ -e /usr/share/icons ] || sudo mkdir -v /usr/share/icons
	[ -e /usr/share/themes ] ||	sudo mkdir -v /usr/share/themes
	sudo tar -C /usr/share/fonts -xf fonts-themes/fonts.tar.xz
	sudo tar -C /usr/share/icons -xf fonts-themes/icons.tar.xz
	sudo tar -C /usr/share/themes -xf fonts-themes/themes.tar.xz
	rm -rf fonts-themes/
	clear
	printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m Fonts, themes and icons successfully extracted to the \033[0;34m\033[4m/usr/share/\033[0m folder"
	sleep 2
	clear
	echo "Downloading Deepin DE wallpapers"
	sudo dnf in deepin-wallpapers -y
	sleep 2
}
#
#
getAllSoft() {
	clear
	echo "Adding software repositories"
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ && sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf in https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm -y
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg && sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	clear
	echo "Installing software collection"
	sudo dnf in brave-browser celluloid cmus geeqie onlyoffice-desktopeditors pcmanfm sublime-text xarchiver zathura-pdf-poppler -y && xdg-mime default sublime_text.desktop text/plain && xdg-mime default org.pwmt.zathura.desktop application/pdf
	echo "Downloading Mark Text as AppImages and creating symlink"
	curl -L --create-dirs --output-dir "$HOME"/Applications --remote-name-all https://github.com/marktext/marktext/releases/latest/download/marktext-x86_64.AppImage && chmod +x "$HOME"/Applications/*.AppImage && sudo ln -sf "$HOME"/Applications/marktext-x86_64.AppImage /usr/bin/marktext
}
#
#
purgeLeftOvers() {
	clear
	printf -- "Deleting the following files from your \033[0;34m\033[4m\"\$HOME\"\033[0m folder:\n.gitignore\nDavidsArchTool.sh\nDavidsFedoraTool.sh\nREADME.md\n"
	sudo rm -rf .gitignore DavidsArchTool.sh DavidsFedoraTool.sh README.md
	clear
	printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0mThe cleanup has been completed"
	sleep 2
}
#
#
getPretty() {
	clear
	printf -- "Type your password to write a new lightdm settings file"
	[ -e /etc/lightdm/lightdm-gtk-greeter.conf ] && sudo mv -v /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.bak
	printf -- "[greeter]\nbackground=/usr/share/wallpapers/deepin/Scenery_in_Plateau_by_Arto_Marttinen.jpg\nclock-format=%%A, %%B %%d %%I:%%M %%p\ncursor-theme-name=Vimix-cursors\nfont-name=SF Pro Text\nicon-theme-name=Tela-circle-grey-dark\ntheme-name=Plata-Noir-Compact" | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m New lightdm settings writen at \033[0;34m\033[4m/etc/lightdm/lightdm-gtk-greeter.conf\033[0m" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m The settings could not be written at \033[0;34m\033[4m/etc/lightdm/lightdm-gtk-greeter.conf\033[0m"
	sleep 2
	clear
	echo "Installing starship shell prompt"
	sudo dnf copr enable atim/starship -y && sudo dnf in starship -y
	sleep 2
}
#
#
invalid () {
	printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m Invalid answer, Please try again"
	sleep 2
}
#
#
clear
cd "$HOME" && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m Running from \033[0;34m\033[4m%s\033[0m" "$HOME" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m Something went wrong when entering your \033[0;34m\033[4m\"\$HOME\"\033[0m folder"
sleep 2
showWelcome
showMainMenu
#
#
# Disclaimer:
#
# THIS SOFTWARE IS PROVIDED BY DAVID35MM “AS IS” AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL EZNIX BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# END
#
