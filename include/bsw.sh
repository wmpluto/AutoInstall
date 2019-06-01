#!/bin/bash

Get_Dist_Version()
{
    if command -v python2 >/dev/null 2>&1; then
        eval ${DISTRO}_Version=$(python2 -c 'import platform; print platform.linux_distribution()[1]')
    elif command -v python3 >/dev/null 2>&1; then
        eval ${DISTRO}_Version=$(python3 -c 'import platform; print(platform.linux_distribution()[1])')
    fi
    if [ $? -ne 0 ]; then
        Install_LSB
        eval ${DISTRO}_Version=`lsb_release -rs`
    fi
}

Get_OS_Bit()
{
    if [[ `getconf WORD_BIT` = '32' && `getconf LONG_BIT` = '64' ]] ; then
        Is_64bit='y'
    else
        Is_64bit='n'
    fi
}

Download_Files()
{
    local URL=$1
    local FileName=$2
    if [ -s "${FileName}" ]; then
        echo "${FileName} [found]"
    else
        echo "Notice: ${FileName} not found!!!download now..."
        wget -c --progress=bar:force --prefer-family=IPv4 --no-check-certificate ${URL}
    fi
}

Tar_Cd()
{
    local FileName=$1
    local DirName=$2
    cd ${cur_dir}/src
    [[ -d "${DirName}" ]] && rm -rf ${DirName}
    echo "Uncompress ${FileName}..."
    tar zxf ${FileName}
    if [ -n "${DirName}" ]; then
        echo "cd ${DirName}..."
        cd ${DirName}
    fi
}

Tarj_Cd()
{
    local FileName=$1
    local DirName=$2
    cd ${cur_dir}/src
    [[ -d "${DirName}" ]] && rm -rf ${DirName}
    echo "Uncompress ${FileName}..."
    tar jxf ${FileName}
    if [ -n "${DirName}" ]; then
        echo "cd ${DirName}..."
        cd ${DirName}
    fi
}

Print_Sys_Info()
{
    echo "LNMP Version: ${LNMP_Ver}"
    eval echo "${DISTRO} \${${DISTRO}_Version}"
    cat /etc/issue
    cat /etc/*-release
    uname -a
    MemTotal=`free -m | grep Mem | awk '{print  $2}'`
    echo "Memory is: ${MemTotal} MB "
    df -h
}


Color_Text()
{
  echo -e " \e[0;$2m$1\e[0m"
}

Echo_Red()
{
  echo $(Color_Text "$1" "31")
}

Echo_Green()
{
  echo $(Color_Text "$1" "32")
}

Echo_Yellow()
{
  echo $(Color_Text "$1" "33")
}

Echo_Blue()
{
  echo $(Color_Text "$1" "34")
}
