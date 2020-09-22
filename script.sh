#/bin/bash

red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
nc='\e[0m'

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

_verify() {
	error_code=$1
	message=$2

	if [[ $1 -ne 0 ]]; then
		echo "${red}[ERROR]${nc} Something went wrong adding the ${yellow}$2${nc}, please review"
		exit 1
	else
		echo -e "${green}[SUCCESS]${nc} Package ${yellow}$2${nc} installed successfully"
	fi
	
}

_add_packages() {
	apt-get update; apt-get dist-upgrade -y &> /dev/null

	echo "Installing git"

	sudo apt-get install -y git &> /dev/null

	_verify $? "git"

	echo "Installing software properties common"

	sudo apt-get install -y software-properties-common &> /dev/null

	_verify $? "software-properties-common"

	echo "Installing QT 4 PPA"

	sudo add-apt-repository ppa:rock-core/qt4 -y  &> /dev/null

	_verify $? "QT 4 PPA"

	echo "Installing QT4"

	apt-get install libqt4* libqtcore4 libqtgui4 libqtwebkit4 qt4* libqt4-dev libminiupnpc-dev -y  &> /dev/null

	_verify $? "QT 4"

	echo "installing mingw"

	apt-get install -y mingw-w64  &> /dev/null

	_verify $? "mingw-w64"

	echo "Installing build-essentials"

	apt-get -y install build-essential  &> /dev/null

	_verify $? "build-essential"

	echo "Installing libboost-dev"

	apt-get install -y libboost-dev  &> /dev/null

	_verify $? "libboost-dev"

	echo "Installing libssl-dev"

	apt-get install -y libssl-dev &> /dev/null 

	_verify $? "libssl1.1-dev"

	echo "Installing libdb"

	apt-get install -y libdb-dev libdb++-dev  &> /dev/null

	_verify $? "libdb++-dev"

	cd /tmp/


	make install  &> /dev/null

	cd
}

_prepare_electron() {
	_add_packages
}

_prepare_electron
