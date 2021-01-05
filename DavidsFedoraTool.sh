#!/bin/bash

handlerr () {
	clear
	trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
}
#
#
welcome () {
	clear
	echo "==================================================="
	echo "=                                                 ="
	echo "=     Welcome to David Salomon's Fedora tool      ="
	echo "=                                                 ="
	echo "=     Version 1.3                                 ="
	echo "=                                                 ="
	echo "=     Brought to you by david35mm                 ="
	echo "=     https://github.com/david35mm/.files         ="
	echo "=                                                 ="
	echo -e "=================================================== \n"
	sleep 4
}
#
#
gitinst () {
	clear
	sudo dnf in git -y
	sleep 1
	clear
	echo -e "\n"
	echo "Git was installed successfully"
	sleep 2
	clear
}
#
#
clone () {
	clear
	git clone https://github.com/david35mm/.files.git
	sleep 1
	clear
	echo -e "\n"
	echo "You have cloned David's repo successfully"
	sleep 2
	clear
}
#
#
clonebare () {
	clear
	echo "These script will remove your .config/ folder and your .bashrc"
	echo "You have 5 seconds to press Ctrl+C on your keyboard to cancel"
	sleep 5
	git clone --bare https://github.com/david35mm/.files.git $HOME/.files
	sleep 1
	sudo rm -rf .config/ .bashrc
	alias config='/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME'
	config checkout
	config config --local status.showUntrackedFiles no
	echo -e "\n"
	echo "You have cloned David's repo successfully"
	sleep 2
	clear
}
#
#
confdnf () {
	clear
	echo "You need to have copied my repo before for this to work"
	sleep 2
	clear
	echo "Copying dnf.conf to /etc/dnf/"
	sudo cp dnf.conf /etc/dnf/
	sleep 2
	clear
	echo "Creating common aliases for DNF"
	sudo dnf alias add if='info'
	sudo dnf alias add in='install'
	sudo dnf alias add rm='remove'
	sudo dnf alias add lu='list updates'
	sudo dnf alias add purge-kernels='\rm $(dnf repoquery --installonly --latest-limit=-1 -q)'
	sudo dnf alias add up='upgrade'
	sudo dnf alias add wp='provides'
	sudo dnf alias add lr='repolist'
	sudo dnf alias add ref='makecache'
	sudo dnf alias add clean='\clean all'
	sleep 2
	echo -e "\n"
	echo "You have made DNF more usable"
	sleep 2
	clear
}
#
#
instqtile () {
	clear
	echo "Removing old versions of Qtile"
	sudo dnf rm qtile -y
	clear
	echo "Installing Qtile dependencies"
	sudo dnf in python3-xcffib python3-cffi python3-cairocffi python3-dbus python3-psutil lm_sensors
	sleep 2
	echo "Qtile dependencies installed successfully"
	sudo pip install qtile
	sleep 2
	clear
	echo -e "\n"
	echo "Qtile was installed successfully"
	sleep 2
	clear
}
#
#
instspectr () {
	clear
	sudo dnf in spectrwm -y
	sleep 2
	clear
	echo -e "\n"
	echo "spectrwm was installed successfully"
	sleep 2
	clear
}
#
#
instherbst () {
	clear
	sudo dnf copr enable david35mm/herbstluftwm -y
	sudo dnf in herbstluftwm -y
	sleep 2
	clear
	echo -e "\n"
	echo "herbstluftwm was installed successfully"
	sleep 2
	clear
}
#
#
instutils () {
	clear
	sudo dnf in brightnessctl lm_sensors ytop alacritty picom nitrogen rofi lxappearance flameshot dunst polybar lxpolkit xfce4-power-manager neovim switchboard -y
	sleep 2
	clear
	echo -e "\n"
	echo "Utils were installed successfully"
	sleep 2
	clear
}
#
#
instthemesicons () {
	clear
	sudo cp -R .themes/ /usr/share/themes/
	sudo cp -R .icons/ /usr/share/icons/
	sudo dnf in elementary-wallpapers -y
	sleep 2
	clear
	echo -e "\n"
	echo "Themes, icons & wallpapers were installed successfully"
	sleep 2
	clear
}
#
#
instfonts () {
	clear
	git clone git@github.com:david35mm/fonts.git
	sudo cp -R fonts /usr/share/fonts/
	sudo rm -rf fonts/
	sleep 2
	clear
	echo -e "\n"
	echo "Fonts were installed successfully"
	sleep 2
	clear
}
#
#
instaao () {
	clear
	sudo dnf install dnf-plugins-core -y
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf in https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
	sudo dnf in https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm -y
	sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
	sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
	sudo dnf in brave-browser nemo nemo-terminal vlc cmus geeqie zathura-pdf-mupdf onlyoffice-desktopeditors sublime-text -y
	sleep 2
	clear
	echo -e "\n"
	echo "Software was installed successfully"
	sleep 2
	clear
}
#
#
durf () {
	clear
	sudo rm -rf .themes/ .icons/ dnf.conf lightdm-gtk-greeter.conf README.md .gitignore
	sleep 2
	clear
	echo -e "\n"
	echo "The cleanup has been completed"
	sleep 2
	clear
}
#
#
beauty () {
	clear
	sudo cp lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
	sudo curl -fsSL https://starship.rs/install.sh | bash
	sleep 2
	clear
	echo -e "\n"
	echo "Beautification completed"
	sleep 2
	clear
}
#
#
invalid () {
	echo -e "\n"
	echo "Invalid answer, Please try again"
	sleep 2
}
#
#
gitbareclone () { while true
do
	clear
	echo "----------------------------------"
	echo " Clone David's GitHub repository"
	echo "----------------------------------"
	echo ""
	echo "  1) Install Git"
	echo "  2) Git clone the repo"
	echo "  3) Clone the repo with the --bare flag"
	echo ""
	echo "  R) Return to menu"
	echo -e "\n"
	read -p "Please enter your choice: " choice2
	case $choice2 in
		1 ) gitinst;;
		2 ) clone ;;
		3 ) clonebare ;;
		r|R ) main_menu ;;
		* ) invalid ;;
	esac
done
}
#
#
wminst () { while true
do
	clear
	echo "---------------------------------------------"
	echo " Install window managers and some utilities"
	echo "---------------------------------------------"
	echo ""
	echo "  1) Install Qtile"
	echo "  2) Install spectrwm"
	echo "  3) Install herbstluftwm"
	echo "  4) Install utils (picom, dunst, nitrogen, etc)"
	echo "  5) Install themes, icons & wallpapers"
	echo "  6) Install fonts (For David only!)"
	echo ""
	echo "  R) Return to menu"
	echo -e "\n"
	read -p "Please enter your choice: " choice3
	case $choice3 in
		1 ) instqtile ;;
		2 ) instspectr ;;
		3 ) instherbst ;;
		4 ) instutils ;;
		5 ) instthemesicons ;;
		6 ) instfonts ;;
		r|R ) main_menu ;;
		* ) invalid ;;
	esac
done
}
#
#
inst_soft () { while true
do
	clear
	echo "--------------------------------"
	echo " Install Software Categories"
	echo "--------------------------------"
	echo ""
	echo " This Section will install the following software:"
	echo " Browser (Brave), file Manager (nemo), multimedia (VLC, Geeqie & cmus)"
	echo " PDF reader (Zathura), OfficeSuite (OnlyOffice), Text editor (Sublime Text)"
	echo ""
	echo " Install all at once? (y/N)"
	echo ""
	echo "  R) Return to menu"
	echo -e "\n"
	read -p "Please enter your choice: " choice4
	case $choice4 in
		y|Y ) instaao ;;
		n|N ) main_menu ;;
		r|R ) main_menu ;;
		* ) invalid ;;
	esac
done
}
#
#
main_menu () { while true
do
	clear
	echo "-------------------------------------"
	echo " David Salomon's Fedora Tool"
	echo "-------------------------------------"
	echo "  1) Clone David's GitHub repository"
	echo "  2) Configure DNF with better settings"
	echo "  3) Install window managers and some utilities"
	echo "  4) Install Software Categories"
	echo "  5) Delete unnecessary remaining files"
	echo "  5) Beautify!"
	echo ""
	echo "  X) Exit"
	echo -e "\n"
	read -p "Enter your choice: " choice1
	case $choice1 in
		1 ) gitbareclone ;;
		2 ) confdnf ;;
		3 ) wminst ;;
		4 ) inst_soft ;;
		5 ) durf ;;
		6 ) beauty ;;
		x|X ) exit;;
		* ) invalid ;;
	esac
done
}
#
#
ROOTUSER () {
	if [[ "$EUID" = 0 ]]; then
		continue
	else
		echo "Please Run As Root"
		sleep 2
		exit
	fi
}
#
#
# ROOTUSER
handlerr
welcome
main_menu
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
