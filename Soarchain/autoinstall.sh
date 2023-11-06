#!/bin/bash
clear
echo "==============================================================================" 
echo -e "\e[92m"
echo "######    ###      #####    #####   ### ###  ######   ######     ###     ###"     
echo " ## ###   ###     ### ###  #######   ## ###  ### ###   ######   #####    ###"     
echo " ## ###   ###     ### ###  ### # #   #####   ###  ##   ##      ### ###   ###"     
echo " #####   ###      ##   ##  ##       #####    ### ###  ######   ### ###  ###"      
echo "### ##   ###      ##   ##  ##       ####     ######   #####    ### ###  ###"      
echo "### ###  ### ###  ### ###  ### # #  ######   ### ###  ###      #######  ### ###"  
echo "#######  #######  #######  #######  ### ###   ### ### #######  ### ###  #######"  
echo "######    #####    #####    #####   ### ###   ### ###  #####    ##  ##   #####" 
echo -e "\e[0m"  
echo "==============================================================================" 

sleep 2

# Setting up dependencies
sudo apt update && sudo apt upgrade -y

# Install Build Requirements
sudo apt install git build-essential ufw curl jq snapd --yes

# Install Go 1.18
wget -q -O - https://git.io/vQhTU | bash -s -- --version 1.18.1

echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
source $HOME/.bash_profile

# Check Go version
go version

# Install Ignite CLI
curl https://get.ignite.com/cli! | bash

# Check Ignite version
ignite version

# Build Soarchain
cd $HOME
git clone git@github.com:soar-robotics/soarchain-core.git
cd soarchain-core
./run_makefile.sh

# Set GOPATH and PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Verify Soarchain installation
soarchind version --long

# Initialize Soarchain Node
# (Insert steps for downloading genesis file here)

# Copy genesis file
cp genesis.json $HOME/.soarchain/config

# Edit config.toml
config_toml_path=$HOME/.soarchain/config/config.toml

cat <<EOL > $config_toml_path
# config.toml content
moniker = "NODE_NAME"
seeds = "Will be given when testnet starts"
persistent_peers = "Will be given when testnet starts"
EOL

# Edit app.toml
app_toml_path=$HOME/.soarchaind/config/app.toml

cat <<EOL > $app_toml_path
# app.toml content
pruning = "default"
minimum-gas-prices = "0.001motus"
EOL

# Start syncing
soarchaind start --log_level info --minimum-gas-prices=0.0001umotus

# Check syncing status
soarchaind status --output json | jq '.sync_info'
