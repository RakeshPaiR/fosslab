echo -e "OS and Kernel: `lsb_release -a`"
echo -e "Shells: `cat /etc/shells`"
echo -e "CPU Info:`sudo dmidecode -t 4`"
echo -e "Memory Info:`free -m`"
echo -e "Hard Disk info: `sudo dmidecode -t memory`"
echo -e "File System (Mounted): `sudo fdisk -l`"
