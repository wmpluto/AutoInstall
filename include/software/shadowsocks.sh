#!/bin/bash

PreConf_Shadowsocks()
{
    Echo_Blue "Pre-configure shadowsocks..."

    ss_server_port="8388"
    Echo_Yellow "Setup the port of shadowsocks"
    read -p "Please enter: " ss_server_port

    ss_password="null"
    Echo_Yellow "Setup the password of shadowsocks"
    read -p "Please enter: " ss_password
}

Configure_Shadowsocks()
{
    config_path="/etc/shadowsocks-libev/config.json"
    cp $config_path /etc/shadowsocks-libev/config.json_bak 
    echo '' > $config_path
    echo { >> $config_path
    echo '    "server"': '"0.0.0.0"', >> $config_path
    echo '    "server_port"': $ss_server_port, >> $config_path
    echo '    "local_port"': 1080, >> $config_path
    echo '    "password"': '"'$ss_password'"', >> $config_path
    echo '    "timeout"': 60, >> $config_path
    echo '    "method"': '"aes-256-gcm"' >> $config_path
    echo } >> $config_path
}

Install_Shadowsocks()
{
    Echo_Blue "[+] Installing shadowsocks..."
    apt install -y shadowsocks-libev

    Configure_Shadowsocks

    service shadowsocks-libev restart 
}