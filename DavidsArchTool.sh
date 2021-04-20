#!/bin/sh

showWelcome() {
	clear
	echo "==================================================="
	echo "=                                                 ="
	echo "=     Welcome to David Salomon's Arch tool        ="
	echo "=                                                 ="
	echo "=     Version 4.0                                 ="
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
	echo " David Salomon's Arch Tool"
	printf -- "-------------------------------------\n\n"
	echo "  1) Install NetworkManager and configure DNS"
	echo "  2) Install paru and configure pacman"
	echo "  3) Install the X11 Display Server"
	echo "  4) Clone David's GitHub repository"
	echo "  5) Install window managers and some utilities"
	echo "  6) Install software collection"
	echo "  7) Beautify! (Install starship prompt and configure ligthdm)"
	printf -- "  8) Delete unnecessary remaining files (Make sure this is the last you do)\n\n"
	printf -- "  X) Exit\n\n"
	printf "Enter your choice: "
	read -r choice </dev/tty 
	case $choice in
		1 ) confNetwork ;;
		2 ) confPacman ;;
		3 ) getXorg ;;
		4 ) showGitMenu ;;
		5 ) showWMInstMenu ;;
		6 ) showSoftInstMenu ;;
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
	printf -- "----------------------------------\n\n"
	echo "  1) Install Git"
	printf -- "  2) Clone the repo (with the --bare flag)\n\n"
	printf -- "  R) Return to menu\n\n"
	printf -- "  DISCLAIMER: Be aware that by cloning the repo some important files in your home folder are going to be erased\n\n"
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
	printf -- "  5) Install fonts, themes, icons & wallpapers\n\n"
	printf -- "  R) Return to menu\n\n"
	printf "Please enter your choice: "
	read -r choice </dev/tty
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
showSoftInstMenu() {
	while true
do
	clear
	echo "--------------------------------"
	echo " Install software collection"
	printf -- "--------------------------------\n\n"
	printf -- "This section will install the following software:\nBrowser (Brave), file manager (nemo), multimedia (VLC, Geeqie & cmus)\nPDF reader (Zathura), office suite (OnlyOffice), text editor (Sublime Text)\n\nInstall all at once? (y/N)\n\n"
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
	sudo pacman -S --noconfirm --needed lightdm-gtk-greeter xorg-server
	sleep 2
	clear
	echo "Initializing lightdm service and changing the default systemd target to 'graphical'"
	sudo systemctl enable lightdm
	sudo systemctl set-default graphical.target
	sleep 2
}
#
#
getGit() {
	clear
	echo "Installing Git"
	sudo pacman -S --noconfirm --needed git
	sleep 2
}
#
#
getRepo() {
	clear
	printf -- "This script will remove the following files and folders:\n.bashrc\n.config/\n.files/\n.gitignore\n.screenshots/\n.vimrc\n.Xresources\nDavidsArchTool.sh\nDavidsFedoraTool.sh\nREADME.md\n\n\tYou have 5 seconds to press Ctrl+C on your keyboard to cancel\n"
	sleep 5
	sudo rm -rf .bashrc .config/ .files/ .gitignore .screenshots/ .vimrc .Xresources DavidsArchTool.sh DavidsFedoraTool.sh README.md
	git clone --bare https://github.com/david35mm/.files.git "$HOME"/.files && /usr/bin/git --git-dir="$HOME"/.files/ --work-tree="$HOME" checkout && /usr/bin/git --git-dir="$HOME"/.files/ --work-tree="$HOME" config --local status.showUntrackedFiles no && sleep 4 && clear && printf -- "\n\tYou have cloned David's repo successfully" || printf -- "\n\tThere was an error cloning the repo"
	sleep 4
}
#
#
confNetwork() {
	clear
	echo "Installling NetworkManager"
	sudo pacman -S --noconfirm --needed networkmanager
	sleep 2
	clear
	echo "Setting Cloudflare as primary DNS and Quad9 as secondary"
	printf -- "DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001\nDNSOverTLS=yes\nDNSSEC=yes\nDomains=~.\nFallbackDNS=9.9.9.9 149.112.112.112 2620:fe::fe 2620:fe::9" | sudo tee -a /etc/systemd/resolved.conf && sudo systemctl enable NetworkManager systemd-resolved && printf -- "\n\tYou have configured NetworkManager successfully" || printf -- "\n\tThere was an error configuring NetworkManager"
	sleep 4
}
#
#
confPacman() {
	clear
	echo "Installing paru build dependencies"
	sudo pacman -S --noconfirm --needed base-devel git pacman-contrib reflector
	sleep 2
	clear
	"Cloning paru Git repository"
	rm -rf paru-bin
	git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && clear && echo "Installing paru" && makepkg -si && sleep 2 && cd "$HOME" && printf -- "\n\tparu has been installed successfully" || printf -- "\n\tThere was an error installing paru"
	sleep 4
	clear
	echo "Type your password to write better settings at /etc/pacman.conf"
	sudo $EDITOR /etc/pacman.conf
	clear
	echo "Using reflector to select the fastest mirrors"
	sudo reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	sleep 2
	clear
	printf -- "\n\tYou have made pacman a little prettier and selected the fastest mirrors"
	clear
	sleep 2
}
#
#
getQtile() {
	echo "Installing Qtile"
	sudo pacman -S --noconfirm --needed qtile
	sudo pacman -S --noconfirm --needed --asdeps python-psutil python-iwlib
	sleep 2
	clear
	printf -- "\n\tQtile was installed successfully"
	sleep 2
}
#
#
getSpectrwm() {
	clear
	echo "Installing Spectrwm"
	sudo pacman -S --noconfirm --needed spectrwm
	sleep 2
	clear
	printf -- "\n\tSpectrwm was installed successfully"
	sleep 2
}
#
#
getHerbstluft() {
	clear
	echo "Installing Herbstluftwm"
	sudo pacman -S --noconfirm --needed herbstluftwm
	sleep 2
	clear
	printf -- "\n\tHerbstluftwm was installed successfully"
	sleep 2
}
#
#
getUtils() {
	clear
	echo "Installing utilities"
	sudo pacman -S --noconfirm --needed alacritty alsa-utils arandr bat blueman brightnessctl dunst exa fd fish flameshot gvfs gvfs-mtp libmtp libnotify lxappearance lxsession-gtk3 neovim nitrogen nm-connection-editor ntfs-3g pavucontrol picom pipewire-alsa pipewire-jack pipewire-pulse rofi starship udiskie
	paru -S --cleanafter --needed --noconfirm --removemake --skipreview dashbinsh ytop-bin
	sleep 2
	clear
	printf -- "\n\tUtilities were installed successfully"
	sleep 2
}
#
#
getThemesIcons() {
	clear
	sudo rm -rf fonts-themes/
	git clone https://github.com/david35mm/fonts-themes.git
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
	sudo pacman -S --noconfirm --needed deepin-wallpapers
	sleep 2
	clear
	printf -- "\n\tThemes, icons & wallpapers were installed successfully"
	sleep 2
}
#
#
getAllSoft() {
	clear
	echo "Adding additional software repositories"
	curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg && printf -- "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
	clear
	echo "Installing software collection"
	sudo pacman -Syyu --noconfirm --needed pcmanfm vlc cmus geeqie zathura-pdf-poppler sublime-text xarchiver && xdg-mime default sublime_text.desktop text/plain && xdg-mime default org.pwmt.zathura.desktop application/pdf
	paru -S --cleanafter --needed --noconfirm --removemake --skipreview brave-bin onlyoffice-bin
	sleep 2
	clear
	printf -- "\n\tSoftware was installed successfully"
	sleep 2
}
#
#
purgeLeftOvers() {
	clear
	printf -- "Deleting the following files from your home folder:\n.gitignore\n.icons/\n.screenshots/\n.themes/\nDavidsArchTool.sh\nDavidsFedoraTool.sh\nREADME.md"
	sudo rm -rf .gitignore .screenshots/ DavidsArchTool.sh DavidsFedoraTool.sh README.md
	clear
	printf -- "\n\tThe cleanup has been completed"
	sleep 2
}
#
#
getPretty() {
	clear
	echo "Type your password to write a new lightdm config"
	printf -- "background=/usr/share/wallpapers/deepin/Scenery_in_Plateau_by_Arto_Marttinen.jpg\nclock-format=%%A, %%B %%d %%I:%%M %%p\ncursor-theme-name=Vimix-cursors\nfont-name=SF Pro Text\nicon-theme-name=Tela-circle-grey-dark\ntheme-name=Plata-Noir-Compact" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf && printf -- "\n\n\tLightdm config was written successfully" || printf -- "\n\tThere was an error writing the Lightdm config"
	sleep 2
	clear
	echo "Installing starship shell prompt"
	sudo pacman -S --noconfirm --needed starship
	sleep 2
	clear
	printf -- "\n\tBeautification completed"
	sleep 2
}
#
#
invalid () {
	printf -- "\n\tInvalid answer, Please try again"
	sleep 2
}
#
#
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
