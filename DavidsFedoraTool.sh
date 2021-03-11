#!/bin/bash

showWelcome() {
	clear
	echo "==================================================="
	echo "=                                                 ="
	echo "=     Welcome to David Salomon's Fedora tool      ="
	echo "=                                                 ="
	echo "=     Version 4.4                                 ="
	echo "=                                                 ="
	echo "=     Brought to you by david35mm                 ="
	echo "=     https://github.com/david35mm/.files         ="
	echo "=                                                 ="
	echo -e "===================================================\n"
	sleep 4
}
#
#
showMainMenu() { while true
do
	clear
	echo "-------------------------------------"
	echo " David Salomon's Fedora Tool"
	echo -e "-------------------------------------\n"
	echo "  1) Configure DNF with better settings"
	echo "  2) Install the X11 Display Server"
	echo "  3) Clone David's GitHub repository"
	echo "  4) Install window managers and some utilities"
	echo "  5) Install software collection"
	echo "  6) Install programming languages"
	echo "  7) Beautify!"
	echo -e "  8) Delete unnecessary remaining files (Make sure this is the last you do)\n"
	echo -e "  X) Exit\n"
	read -p "Enter your choice: " choice
	case $choice in
		1 ) confDNF ;;
		2 ) getXorg ;;
		3 ) showGitMenu ;;
		4 ) showWMInstMenu ;;
		5 ) showSoftInstMenu ;;
		6 ) showProgramLangMenu ;;
		7 ) getPretty ;;
		8 ) purgeLeftOvers ;;
		x|X ) exit;;
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
	echo " Clone David's GitHub repository"
	echo -e "----------------------------------\n"
	echo "  1) Install Git"
	echo -e "  2) Clone the repo (with the --bare flag)\n"
	echo -e "  R) Return to menu\n"
	echo -e "  DISCLAIMER: Be aware that by cloning the repo some important files in your home folder are going to be erased\n"
	read -p "Please enter your choice: " choice
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
	echo -e "---------------------------------------------\n"
	echo "  1) Install Qtile"
	echo "  2) Install Spectrwm"
	echo "  3) Install Herbstluftwm"
	echo "  4) Install utils (picom, dunst, nitrogen, etc)"
	echo "  5) Install fonts, themes, icons & wallpapers"
	echo -e "  R) Return to menu\n"
	read -p "Please enter your choice: " choice
	case $choice in
		1 ) getQtile ;;
		2 ) getSpectrwm ;;
		3 ) getHerbstluft ;;
		4 ) getUtils ;;
		5 ) getThemesIcons ;;
		r|R ) showMainMenu ;;
		* ) invalid ;;
	esac
done
}
#
#
showSoftInstMenu() { while true
do
	clear
	echo "--------------------------------"
	echo " Install software collection"
	echo -e "--------------------------------\n"
	echo -e "This section will install the following software:\nBrowser (Brave), file manager (nemo), multimedia (VLC, Geeqie & cmus)\nPDF reader (Zathura), office suite (OnlyOffice), text editor (Sublime Text)\n\nInstall all at once? (y/N)\n"
	echo -e "  R) Return to menu\n"
	read -p "Please enter your choice: " choice
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
showProgramLangMenu() {
	while true
do
	clear
	echo "--------------------------------"
	echo " Install programming languages"
	echo -e "--------------------------------\n"
	echo -e "  Note: I know it's kind of dissapointing just to see one language on the list.\n  I'll be adding more in the future\n"
	echo -e "  1) Install Go\n"
	echo -e "  R) Return to menu\n"
	read -p "Please enter your choice: " choice
	case $choice in
		1 ) getGo ;;
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
	sudo dnf in git -y
	sleep 2
}
#
#
getRepo() {
	clear
	echo -e "This script will remove the following files and folders:\n.bashrc\n.config/\n.files/\n.gitignore\n.screenshots/\n.vimrc\n.Xresources\nDavidsFedoraTool.sh\nREADME.md\n\n\tYou have 5 seconds to press Ctrl+C on your keyboard to cancel"
	sleep 5
	sudo rm -rf .bashrc .config/ .files/ .gitignore .screenshots/ .vimrc .Xresources DavidsFedoraTool.sh README.md
	git clone --bare https://github.com/david35mm/.files.git $HOME/.files
	/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME checkout
	/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME config --local status.showUntrackedFiles no
	sleep 4
	clear
	echo -e "\n\tYou have cloned David's repo successfully"
	sleep 2
}
#
#
confDNF() {
	clear
	echo "Type your password to write better settings at /etc/dnf/dnf.conf"
	su -c 'echo -e "[main]\nbest=True\ncheck_config_file_age=False\nclean_requirements_on_remove=True\ncolor=always\ndefaultyes=True\ndeltarpm=True\ndiskspacecheck=False\nfastestmirror=True\ngpgcheck=1\ninstallonly_limit=2\nip_resolve=4\nkeepcache=False\nmax_parallel_downloads=10\nmetadata_expire=never\nmetadata_timer_sync=0\nskip_if_unavailable=True" > /etc/dnf/dnf.conf'
	clear
	echo "Settings written at /etc/dnf/dnf.conf"
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
	clear
	echo -e "\n\tYou have made DNF more usable"
	sleep 2
}
#
#
getQtile() {
	clear
	echo "Removing old versions of Qtile"
	sudo dnf rm qtile -y
	sleep 2
	clear
	echo "Installing Qtile dependencies"
	sudo pip install xcffib cairocffi dbus-next psutil
	sleep 2
	clear
	echo "Installing Qtile trough python-pip"
	sudo pip install qtile
	sleep 4
	clear
	echo "Type your password to write .desktop file at /usr/share/xsessions/qtile.desktop"
	sudo mkdir /usr/share/xsessions
	su -c 'echo -e "[Desktop Entry]\nName=Qtile\nComment=Qtile Session\nExec=qtile start\nType=Application\nKeywords=wm;tiling" > /usr/share/xsessions/qtile.desktop'
	clear
	echo -e "\n\tQtile was installed successfully"
	sleep 2
}
#
#
getSpectrwm() {
	clear
	echo "Installing Spectrwm"
	sudo dnf in spectrwm -y
	sleep 2
	clear
	echo -e "\n\tSpectrwm was installed successfully"
	sleep 2
}
#
#
getHerbstluft() {
	clear
	echo "Installing Herbstluftwm"
	sudo dnf copr enable david35mm/herbstluftwm -y
	sudo dnf in herbstluftwm -y
	sleep 2
	clear
	echo -e "\n\tHerbstluftwm was installed successfully"
	sleep 2
}
#
#
getUtils() {
	clear
	echo "Installing utilities"
	sudo dnf copr enable david35mm/bat -y && sudo dnf copr enable david35mm/fd -y && sudo dnf copr enable david35mm/macho -y
	sudo dnf in alacritty alsa-utils arandr bat blueman brightnessctl dunst exa fd fish flameshot gvfs gvfs-fuse gvfs-mtp libmtp libnotify lxappearance lxpolkit macho neovim nitrogen nm-connection-editor ntfs-3g pavucontrol picom pipewire-alsa pipewire-plugin-jack pipewire-pulseaudio polybar pulseaudio-utils rofi udiskie xfce4-power-manager ytop -y
	sleep 2
	clear
	echo -e "\n\tUtilities were installed successfully"
	sleep 2
}
#
#
getThemesIcons() {
	clear
	sudo rm -rf fonts-themes/
	git clone https://github.com/david35mm/fonts-themes.git
	sudo dnf in tar -y
	echo "Extracting fonts, themes and icons to the /usr/share/ folder"
	sudo mkdir /usr/share/fonts /usr/share/icons /usr/share/themes
	sudo tar -C /usr/share/fonts -xf fonts-themes/fonts.tar.xz
	sudo tar -C /usr/share/icons -xf fonts-themes/icons.tar.xz
	sudo tar -C /usr/share/themes -xf fonts-themes/themes.tar.xz
	sudo rm -rf fonts-themes/
	clear
	echo "Fonts, themes and icons successfully extracted to the /usr/share folder"
	sleep 2
	clear
	echo "Installing Deepin DE wallpapers"
	sudo dnf in deepin-wallpapers -y
	sleep 2
	clear
	echo -e "\n\tThemes, icons & wallpapers were installed successfully"
	sleep 2
}
#
#
getAllSoft() {
	clear
	echo "Adding additional software repositories"
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf in https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm -y
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
	sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	clear
	echo "Installing software collection"
	sudo dnf in brave-browser pcmanfm vlc cmus geeqie zathura-pdf-mupdf onlyoffice-desktopeditors sublime-text -y
	sleep 2
	clear
	echo -e "\n\tSoftware was installed successfully"
	sleep 2
}
#
#
getGo() {
	clear
	echo -e "Downloading Go tarball\n"
	wget https://golang.org/dl/go1.16.linux-amd64.tar.gz
	sleep 2
	clear
	echo "Extracting Go at /usr/local/"
	sudo tar -C /usr/local -xzf go1.16.linux-amd64.tar.gz
	echo "Extraction completed successfully"
	sleep 2
	clear
	/usr/local/go/bin/go version
	echo -e "\n\tIf you see 'go version go1.16 linux/amd64' above this line then Go was installed successfully"
	sleep 7
}
#
#
purgeLeftOvers() {
	clear
	echo -e "Deleting the following files from your home folder:\n.gitignore\n.icons/\n.screenshots/\n.themes/\nDavidsFedoraTool.sh\nREADME.md"
	sudo rm -rf .gitignore .screenshots/ DavidsFedoraTool.sh README.md
	clear
	echo -e "\n\tThe cleanup has been completed"
	sleep 2
}
#
#
getPretty() {
	clear
	echo "Type your password to write a new lightdm config"
	su -c 'echo -e "[greeter]\nbackground=/usr/share/wallpapers/deepin/Sunset_of_the_Lake_Nam_by_Wang_Jinyu.jpg\nclock-format=%A, %B %d %I:%M %p\ncursor-theme-name=Vimix-cursors\nfont-name=SF Pro Text\nicon-theme-name=Tela-circle-grey-dark\ntheme-name=Orchis-dark-compact" > /etc/lightdm/lightdm-gtk-greeter.conf'
	echo "Lightdm config was written successfully"
	sleep 2
	clear
	echo "Installing starship shell prompt"
	sudo dnf in tar -y
	sudo curl -fsSL https://starship.rs/install.sh | bash
	sleep 2
	clear
	echo -e "\n\tBeautification completed"
	sleep 2
}
#
#
invalid () {
	echo -e "\n\tInvalid answer, Please try again"
	sleep 2
}
#
#
showWelcome
showMainMenu
#
#
done
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
