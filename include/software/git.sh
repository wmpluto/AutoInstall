#!/bin/bash

PreConf_GIT()
{
    Echo_Blue "Pre-configure ssh for git..."
    ssh-keygen -t rsa -C "wmpluto@gmail.com"   
}

Configure_GIT()
{
    Echo_Blue "[+] Configure git..."
    
    git config --global user.name "Pluto"
    git config --global user.email wmpluto@gmail.com
}

Install_GIT()
{
    Configure_GIT
}
