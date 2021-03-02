up="$(dnf updateinfo -q --list | wc -l)"
if [[ $up -le 0 ]]
then
	echo "Up to date!"
else
	echo "$up Updates"
fi