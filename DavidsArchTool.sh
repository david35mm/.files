#!/bin/bash

showWelcome() {
	clear
	echo "==================================================="
	echo "=                                                 ="
	echo "=     Welcome to David Salomon's Arch tool        ="
	echo "=                                                 ="
	echo "=     Version 2.0                                 ="
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
	echo " David Salomon's Arch Tool"
	echo -e "-------------------------------------\n"
	echo "  1) Install paru and configure pacman"
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
		1 ) confPacman ;;
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
	sudo pacman -S --noconfirm --needed lightdm-gtk-greeter xorg
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
confPacman() {
	clear
	echo "Installing paru build dependencies"
	sudo pacman -S --noconfirm --needed base-devel git pacman-contrib reflector
	sleep 2
	clear
	"Cloning paru Git repository"
	git clone https://aur.archlinux.org/paru-bin.git
	cd paru-bin
	sleep 2
	clear
	echo "Installing paru"
	makepkg -si
	sleep 2
	echo "paru has been installed successfully"
	sleep 2
	clear
	echo "Type your password to write better settings at /etc/pacman.conf"
	sudo nvim /etc/pacman.conf
	clear
	echo -e "\n\tYou have made pacman a little prettier"
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
	echo -e "\n\tQtile was installed successfully"
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
	echo -e "\n\tSpectrwm was installed successfully"
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
	echo -e "\n\tHerbstluftwm was installed successfully"
	sleep 2
}
#
#
getUtils() {
	clear
	echo "Installing utilities"
	sudo pacman -S --noconfirm --needed alacritty alsa-utils arandr bat blueman brightnessctl dunst exa fd fish flameshot gvfs gvfs-mtp libmtp libnotify lxappearance lxsession neovim nitrogen nm-connection-editor ntfs-3g pavucontrol picom pipewire-alsa pipewire-jack pipewire-pulse rofi udiskie
	paru -S --cleanafter --needed --noconfirm --removemake --skipreview macho ytop-bin
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
	echo -e "\n\tThemes, icons & wallpapers were installed successfully"
	sleep 2
}
#
#
getAllSoft() {
	clear
	echo "Adding additional software repositories"
	curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
	echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
	clear
	echo "Installing software collection"
	sudo pacman -S --noconfirm --needed pcmanfm vlc cmus geeqie zathura-pdf-mupdf sublime-text
	paru -S --cleanafter --needed --noconfirm --removemake --skipreview brave-bin onlyoffice-bin
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
	su -c 'echo -e "[greeter]\nbackground=/usr/share/wallpapers/deepin/Scenery_in_Plateau_by_Arto_Marttinen.jpg\nclock-format=%A, %B %d %I:%M %p\ncursor-theme-name=Vimix-cursors\nfont-name=SF Pro Text\nicon-theme-name=Tela-circle-grey-dark\ntheme-name=Orchis-dark-compact" > /etc/lightdm/lightdm-gtk-greeter.conf'
	echo "Lightdm config was written successfully"
	sleep 2
	clear
	echo "Installing starship shell prompt"
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
