#!/bin/bash -e

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER=${USER:-${DEFAULT_USER}}
GROUP=${GROUP:-${USER}}
PASSWD=${PASSWD:-${DEFAULT_PASSWD}}

unset DEFAULT_USER DEFAULT_PASSWD

# Add group
echo "GROUP_ID: $GROUP_ID"
if [[ $GROUP_ID != "0" && ! $(getent group $GROUP) ]]; then
    groupadd -g $GROUP_ID $GROUP
fi

# Add user
echo "USER_ID: $USER_ID"
if [[ $USER_ID != "0" && ! $(getent passwd $USER) ]]; then
    export HOME=/home/$USER
    useradd -d ${HOME} -m -s /bin/bash -u $USER_ID -g $GROUP_ID $USER
fi

# Revert permissions
sudo chmod u-s /usr/sbin/useradd
sudo chmod u-s /usr/sbin/groupadd

if [[ $1 == "/usr/bin/supervisord" ]]; then
    # Set login user name
    USER=$(whoami)
    echo "USER: $USER"

    # Set login password
    echo "PASSWD: $PASSWD"
    echo ${USER}:${PASSWD} | sudo chpasswd

    [[ ! -e ${HOME}/.xsession ]] && \
        cp /etc/skel/.xsession ${HOME}/.xsession
    [[ ! -e /etc/xrdp/rsakeys.ini ]] && \
        sudo -u xrdp -g xrdp xrdp-keygen xrdp /etc/xrdp/rsakeys.ini > /dev/null 2>&1
    [[ ! -e /var/run/xrdp ]] && \
        sudo install -o root -g xrdp -m 2775 -d /var/run/xrdp
    [[ ! -e /var/run/xrdp/sockdir ]] && \
        sudo install -o root -g xrdp -m 3777 -d /var/run/xrdp/sockdir

    if [[ $USER_ID != "0" ]]; then
        [[ ! -e /usr/local/bin/_gosu ]] && \
            sudo install -g $GROUP_ID -m 4750 $(which gosu) /usr/local/bin/_gosu
        set -- /usr/local/bin/_gosu root "$@"
    fi
fi
unset PASSWD

echo "#############################"
exec "$@"
