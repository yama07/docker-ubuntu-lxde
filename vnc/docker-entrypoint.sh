#!/bin/bash -e

USER_ID=$(id -u)
GROUP_ID=$(id -g)
PASSWD=${PASSWD:-${DEFAULT_PASSWD}}
USER=${USER:-${DEFAULT_USER}}

# Generate container group
echo "GROUP_ID: $GROUP_ID"
if [ x"$GROUP_ID" != x"0" ]; then
    groupadd -g $GROUP_ID $USER
fi

# Generate container user
echo "USER_ID: $USER_ID"
if [ x"$USER_ID" != x"0" ]; then
    export HOME=/home/$USER
    useradd -d $HOME -m -s /bin/bash -u $USER_ID -g $GROUP_ID $USER
fi

# Revert permissions
sudo chmod u-s /usr/sbin/useradd
sudo chmod u-s /usr/sbin/groupadd

# Set login use rname
export USER=$(whoami)
echo "USER: $USER"

# Set login password
echo "PASSWD: $PASSWD"
mkdir ${HOME}/.vnc \
    && echo $PASSWD | vncpasswd -f > ${HOME}/.vnc/passwd \
    && chmod 600 ${HOME}/.vnc/passwd

touch ${HOME}/.Xresources

echo "#############################"

# Run VNC server with tail in the foreground
vncserver :1 -geometry 1280x800 -depth 24 && tail -F ${HOME}/.vnc/*.log
