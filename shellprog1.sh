nouser=`who | wc -l`
echo -e "User name: $USER (Login name: $LOGNAME)"
echo -e "Current Shell: $SHELL"
echo -e "Home Directory: $HOME"
echo -e "Your operating system type: $OSTYPE"
echo -e "Path: $PATH"
echo -e "Current Working Directory `pwd`"
echo -e "Current Logged: $nouser"
