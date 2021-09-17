#!/bin/sh

showWelcome() {
	clear
	echo "==================================================="
	echo "=                                                 ="
	printf -- "=     Welcome to \033[3mDavid Salomon's \033[0;34mArch\033[0m tool        =\n"
	echo "=                                                 ="
	echo "=     Version 5                                   ="
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
	printf -- " \033[3mDavid Salomon's \033[0;34mArch\033[0m tool\n"
	printf -- "-------------------------------------\n\n"
	echo "  1) Install iwd and configure DNS"
	echo "  2) Install paru and configure pacman"
	echo "  3) Install the X11 Display Server"
	printf -- "  4) Clone \033[3mDavid's\033[0m GitHub repository\n"
	echo "  5) Install window managers and some utilities"
	echo "  6) Install software collection"
	printf -- "  7) \033[1;30mB\033[0;33me\033[0;31ma\033[0;36mu\033[1;33mt\033[0;32mi\033[0;34mf\033[0;35my\033[0;37m!\033[0m\n"
	printf -- "  8) Delete unnecessary remaining files \033[1m(Make sure this is the last you do)\033[0m\n\n"
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
	sudo pacman -S --noconfirm --needed xorg-server lightdm-gtk-greeter
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
confNetwork() {
	clear
	echo "Configuring wired and wireless networks with systemd-networkd\n"
	[ -e /etc/systemd/network/ ] || sudo mkdir /etc/systemd/network/
	printf -- "[Match]\nName=en*\n\n[Network]\nDHCP=yes\n\n[DHCP]\nRouteMetric=10" | sudo tee /etc/systemd/network/20-wired.network && printf -- "[Match]\nName=wl*\n\n[Network]\nDHCP=yes\n\n[DHCP]\nRouteMetric=20" | sudo tee /etc/systemd/network/25-wireless.network && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m Wired and wireless networks were configured" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m Something happened while configuring wired and wireless networks"
	sleep 2
	clear
	echo "Setting Quad9 as primary DNS and Cloudflare as secondary with systemd-resolved\n"
	[ -e /etc/systemd/resolved.conf ] && sudo mv -v /etc/systemd/resolved.conf /etc/systemd/resolved.conf.bak
	printf -- "[Resolve]\nDNS=9.9.9.9#dns.quad9.net\nFallbackDNS=1.1.1.2#security.cloudflare-dns.com\nDNSOverTLS=yes\nDNSSEC=allow-downgrade\nDomains=~." | sudo tee /etc/systemd/resolved.conf && sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m systemd-resolved has been configured successfully" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m Something happened while writing systemd-resolved config"
	sleep 2
	clear
	echo "Installling iwd"
	sudo pacman -S --noconfirm --needed iwd
	sleep 2
	clear
	echo "Writing iwd settings at \033[0;34m\033[4m/etc/iwd/main.conf\033[0m\n"
	[ -e /etc/iwd/ ] || sudo mkdir /etc/iwd/
	printf -- "[General]\nEnableNetworkConfiguration=false\n\n[Network]\nEnableIPv6=true\nNameResolvingService=systemd\n\n[Scan]\nDisablePeriodicScan=false" | sudo tee /etc/iwd/main.conf && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m iwd setting were successfully written" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m Something happened while writing the \033[0;34m\033[4m/etc/iwd/main.conf\033[0m file"
	sleep 2
	clear
	echo "Enabling systemd services to be started in next boot"
	sudo systemctl enable systemd-networkd systemd-resolved iwd
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
	echo "Cloning paru Git repository"
	[ -e paru-bin ] && rm -rf paru-bin
	git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && clear && echo "Installing paru" && makepkg -si && sleep 2 && printf -- "\n\t\033[0;32m\033[1m● Succeded!\033[0m paru has been installed successfully" || printf -- "\n\t\033[0;31m\033[1m● Error!\033[0m Something happened while building paru"
	cd "$HOME" || exit
	sleep 2
	clear
	printf -- "Type your password to write better settings at \033[0;34m\033[4m/etc/pacman.conf\033[0m\n"
	[ -e /etc/pacman.conf ] && sudo mv -v /etc/pacman.conf /etc/pacman.conf.bak
	sudo "$EDITOR" /etc/pacman.conf
	clear
	echo "Using reflector to select the fastest mirrors"
	sudo reflector --latest 10 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	sleep 2
}
#
#
getQtile() {
	echo "Installing Qtile"
	sudo pacman -S --noconfirm --needed qtile
	sudo pacman -S --noconfirm --needed --asdeps python-psutil python-iwlib
	sleep 2
}
#
#
getSpectrwm() {
	clear
	echo "Installing Spectrwm"
	sudo pacman -S --noconfirm --needed spectrwm
	sleep 2
}
#
#
getHerbstluft() {
	clear
	echo "Installing Herbstluftwm"
	sudo pacman -S --noconfirm --needed herbstluftwm
	sleep 2
}
#
#
getUtils() {
	clear
	echo "Installing utilities"
	sudo pacman -S --noconfirm --needed alacritty alsa-utils bat brightnessctl dunst exa fd fish libnotify lxappearance-gtk3 lxsession-gtk3 neovim nitrogen ntfs-3g picom pipewire-alsa pipewire-jack pipewire-pulse rofi starship udiskie
	paru -S --cleanafter --needed --noconfirm --removemake --skipreview dashbinsh ytop-bin
	sleep 2
	clear
	printf -- "\n\tUtilities were installed successfully"
	sleep 2
}
#
#
getUtilsExtra() {
	clear
	echo "Installing extra utilities"
	sudo pacman -S --noconfirm --needed arandr blueman gvfs gvfs-mtp libmtp maim nm-connection-editor pavucontrol
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
	sudo pacman -S --noconfirm --needed deepin-wallpapers
	sleep 2
}
#
#
getAllSoft() {
	clear
	echo "Adding software repositories"
	curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg && printf -- "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
	clear
	echo "Installing software collection"
	sudo pacman -Syyu --noconfirm --needed celluloid cmus geeqie pcmanfm-gtk3 sublime-text xarchiver zathura-pdf-poppler && xdg-mime default sublime_text.desktop text/plain && xdg-mime default org.pwmt.zathura.desktop application/pdf
	echo "Downloading Brave, OnlyOffice and Mark Text as AppImages and creating symlinks"
	curl -L --create-dirs --output-dir "$HOME"/Applications --remote-name-all https://github.com/srevinsaju/Brave-AppImage/releases/download/stable/Brave-x86_64.AppImage https://github.com/ONLYOFFICE/DesktopEditors/releases/latest/download/DesktopEditors-x86_64.AppImage https://github.com/marktext/marktext/releases/latest/download/marktext-x86_64.AppImage && chmod +x "$HOME"/Applications/*.AppImage && sudo ln -sf "$HOME"/Applications/Brave-x86_64.AppImage /usr/bin/brave-browser && sudo ln -sf "$HOME"/Applications/DesktopEditors-x86_64.AppImage /usr/bin/desktopeditors && sudo ln -sf "$HOME"/Applications/marktext-x86_64.AppImage /usr/bin/marktext
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
	sudo pacman -S --noconfirm --needed starship
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
