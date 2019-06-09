#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cur_dir=$(pwd)

. include/bsw.sh
. include/init.sh
. include/sys.sh
. include/software/bbr.sh
. include/software/git.sh
. include/software/shadowsocks.sh

Echo_Green "+-----------------------------------+"
Echo_Green "| Install software for a new server |"
Echo_Green "+-----------------------------------+"

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

start_time=$(date +%s)

PreConf_SYS
PreConf_GIT
PreConf_Shadowsocks
PreConf_BBR
PreConf_NODE

Update_Software_Source
Install_Dep_Software
Set_Timezone

Install_SYS
Install_GIT
Install_BBR
Install_Shadowsocks
Install_NODE

end_time=$(date +%s)

