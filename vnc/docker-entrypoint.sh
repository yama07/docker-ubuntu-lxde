#!/bin/bash -e

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER=${USER:-${DEFAULT_USER}}
GROUP=${GROUP:-${USER}}
PASSWD=${PASSWD:-${DEFAULT_PASSWD}}
RESOLUTION=${RESOLUTION:-1280x720x24}

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

if (( $# == 0 )); then
    # Set login user name
    USER=$(whoami)
    echo "USER: $USER"

    # Set login password
    echo "PASSWD: $PASSWD"
    echo ${USER}:${PASSWD} | sudo chpasswd
    sudo x11vnc -storepasswd "${PASSWD}" /etc/x11vnc.passwd

    export USER RESOLUTION
    if [[ -e /etc/supervisor/vnc.conf.template ]]; then
        envsubst < /etc/supervisor/vnc.conf.template  | sudo tee /etc/supervisor/vnc.conf > /dev/null
        sudo rm -f /etc/supervisor/vnc.conf.template
    fi
    if [[ -e /etc/lightdm/lightdm.conf.template ]]; then
        envsubst < /etc/lightdm/lightdm.conf.template | sudo tee /etc/lightdm/lightdm.conf > /dev/null
        sudo rm -f /etc/lightdm/lightdm.conf.template
    fi
    if [[ -e /etc/sddm.conf.d/xvfb_autologin.conf.tmplate ]]; then
        envsubst < /etc/sddm.conf.d/xvfb_autologin.conf.tmplate | sudo tee /etc/sddm.conf.d/xvfb_autologin.conf > /dev/null
        sudo rm -f /etc/sddm.conf.d/xvfb_autologin.conf.tmplate
    fi

    RUNTIME_DIR=/run/user/${USER_ID}
    [[ -e $RUNTIME_DIR ]] && sudo rm -rf $RUNTIME_DIR
    sudo install -o $USER_ID -g $GROUP_ID -m 0700 -d $RUNTIME_DIR

    set -- /usr/bin/supervisord -c /etc/supervisor/vnc.conf
    if [[ $USER_ID != "0" ]]; then
        [[ ! -e /usr/local/bin/_alt-su ]] &&
            sudo install -g $GROUP_ID -m 4750 $(which gosu || which su-exec) /usr/local/bin/_alt-su
        set -- /usr/local/bin/_alt-su root "$@"
    fi
fi
unset PASSWD

echo "#############################"
exec "$@"
