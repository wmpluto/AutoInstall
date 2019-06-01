#!/bin/bash

PreConf_SYS()
{
    Echo_Blue "Pre-configure sys..."

    SYS_User="pluto"
    Echo_Yellow "Setup the user name of this server"
    read -p "Please enter: " SYS_User
    SYS_Group="pluto"
    Echo_Yellow "Setup the group name of the user"
    read -p "Please enter: " SYS_Group

    ans="n"
    read -p "Add $SYS_User:$SYS_Group for this server(y/n)? " ans
    if [ "$ans" != "y" ]; then
        exit 1
    fi
}

Configure_User()
{
    addgroup $SYS_User
    useradd -d /home/$SYS_User -g $SYS_Group -s /bin/bash -m $SYS_User
    passwd $SYS_User

    echo "" >> /etc/sudoers
    echo "$SYS_User ALL=(ALL:ALL) ALL" >> /etc/sudoers
}

Configure_SSH()
{
    echo "" >> /etc/ssh/sshd_config
    echo "Port 59847" >> /etc/ssh/sshd_config
    sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
    sed -i "s/Port 22/#Port 22/g" /etc/ssh/sshd_config
}

Configure_Network()
{
    echo '' > /dev/null
}

Configure_SYS()
{
    Configure_User
    Configure_SSH
    Configure_Network
}

Install_SYS()
{
    Configure_SYS
}

