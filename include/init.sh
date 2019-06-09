#!/bin/bash

Set_Timezone()
{
    Echo_Blue "Setting timezone..."
    rm -rf /etc/localtime
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    ntpdate -u pool.ntp.org
}

Update_Software_Source()
{
    Echo_Blue "Update software source..."
    apt update -y
    Echo_Blue "Upgrade software..."
    apt upgrade -y
}

Install_Dep_Software()
{
    Echo_Blue "[+] Installing ntp..."
    apt install -y ntpdate
    Echo_Blue "[+] Installing git..."
    apt install -y git
    Echo_Blue "[+] Installing wget..."
    apt install -y wget
    Echo_Blue "[+] Installing curl..."
    apt install -y curl
    Echo_Blue "[+] Installing python2&python3..."
    apt install -y python
    apt install -y python3
}
