#!/bin/bash

PreConf_KCPTUN()
{
    Echo_Blue "Pre-configure KCPTUN..."

    kcp_folder_path="/home/$SYS_User/tool"
    mkdir "$kcp_folder_path"
    kcp_gz_path='/tmp/kcp.tar.gz'
    udp_config='/etc/sysctl.conf'

    echo 'ulimit -n 65535' >> "/home/$SYS_User/.bashrc"

    echo 'net.core.rmem_max=26214400' >> $udp_config
    echo 'net.core.rmem_default=26214400' >> $udp_config
    echo 'net.core.wmem_max=26214400' >> $udp_config
    echo 'net.core.wmem_default=26214400' >> $udp_config
    echo 'net.core.netdev_max_backlog=2048' >> $udp_config

    kcp_server_port="28999"
    Echo_Yellow "Setup the port of KCPTUN"
    read -p "Please enter: " kcp_server_port

    kcp_password="null"
    Echo_Yellow "Setup the password of KCPTUN"
    read -p "Please enter: " kcp_password
}

Configure_KCPTUN()
{
    config_path="/lib/systemd/system/kcp-server.service"
    echo '#kcp-server.service' > $config_path

    echo '' >> $config_path
    echo '[Unit]' >> $config_path
    echo 'Description=Kcp Server Service' >> $config_path
    echo 'After=network.target' >> $config_path

    echo '' >> $config_path
    echo '[Service]' >> $config_path
    echo 'Type=simple' >> $config_path  
    echo 'ExecStart=nohup  '$kcp_folder_path'/server_linux_amd64 --quiet -t '$IP':'$ss_server_port' -l :'$kcp_server_port' --key ' '"'$kcp_password'"' ' --crypt aes-128  -mtu 1400 -sndwnd 2048 -rcvwnd 2048 -mode fast2 > /dev/null 2>&1  &' >> $config_path 

    echo '' >> $config_path 
    echo '[Install]' >> $config_path 
    echo 'WantedBy=multi-user.target' >> $config_path  
}

Install_KCPTUN()
{
    Echo_Blue "[+] Installing KCPTUN..."

    wget --no-check-certificate -O $kcp_gz_path https://github.com/xtaci/kcptun/releases/download/v20190611/kcptun-linux-amd64-20190611.tar.gz

    tar -xzvf  $kcp_gz_path -C $kcp_folder_path
    
    Configure_KCPTUN

    systemctl daemon-reload
    systemctl enable kcp-server
    systemctl start kcp-server
}