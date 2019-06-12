#!/bin/bash

PreConf_NODE()
{
    echo '' > /dev/null
}

Configure_NODE()
{
    echo '' > /dev/null
}

Install_NODE()
{
    Configure_NODE

    Echo_Blue "[+] Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    
    Echo_Blue "[+] Installing NODE..."
    source "/home/$SYS_User/.bashrc"
    nvm install 7.10.0
    Configure_NODE
}
