#!/bin/bash -e

USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Generate container group
echo "GROUP_ID: $GROUP_ID"
if [ x"$GROUP_ID" != x"0" ]; then
    groupadd -g $GROUP_ID $USER_NAME
fi

# Generate container user
echo "USER_ID: $USER_ID"
if [ x"$USER_ID" != x"0" ]; then
    useradd -d $HOME -s /bin/bash -u $USER_ID -g $GROUP_ID $USER_NAME
fi

# Revert permissions
sudo chmod u-s /usr/sbin/useradd
sudo chmod u-s /usr/sbin/groupadd

# Set HOME dir permission
echo "HOME: ${HOME}"
sudo chown ${USER_ID}:${GROUP_ID} -R $HOME
sudo chmod 755 -R $HOME

# Change password
echo "PASSWD: $PASSWD"
echo `whoami`:${PASSWD} | sudo chpasswd

echo "#############################"

# Run XRDP server with tail in the foreground
sudo bash -c "/etc/init.d/xrdp start && tail -F /var/log/xrdp-sesman.log"
