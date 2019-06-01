#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'


PreConf_BBR()
{
    Echo_Blue "Pre-configure bbr..."
    echo '' > /dev/null
}

Configure_BBR()
{
    echo '' > /dev/null
}

version_ge(){
    test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"
}

check_bbr_status() {
    local param=$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')
    if [[ x"${param}" == x"bbr" ]]; then
        return 0
    else
        return 1
    fi
}


check_kernel_version() {
    local kernel_version=$(uname -r | cut -d- -f1)
    if version_ge ${kernel_version} 4.9; then
        return 0
    else
        return 1
    fi
}

sysctl_config() {
    sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
    sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
    echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
    sysctl -p >/dev/null 2>&1
}

Install_BBR()
{
    Echo_Blue "[+] Installing bbr..."

#    bbr_file_path=/tmp/bbr.sh
#    wget --no-check-certificate -O $bbr_file_path https://github.com/teddysun/across/raw/master/bbr.sh  
#    chmod +x $bbr_file_path
#    echo ' ' | $bbr_file_path
    check_bbr_status
    if [ $? -eq 0 ]; then
        echo
        echo -e "${green}Info:${plain} TCP BBR has already been installed. nothing to do..."
        exit 0
    fi
    check_kernel_version
    if [ $? -eq 0 ]; then
        echo
        echo -e "${green}Info:${plain} Your kernel version is greater than 4.9, directly setting TCP BBR..."
        sysctl_config
        echo -e "${green}Info:${plain} Setting TCP BBR completed..."
    fi

    Configure_BBR
}

