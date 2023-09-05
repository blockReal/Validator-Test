#!/bin/bash

# Setup validator name
read -p "Enter your validator name (MONIKER): " MONIKER

cat <<EOF >zeta.sh
#!/bin/bash

# Setup validator name
MONIKER="YOUR_MONIKER_GOES_HERE"

# Install dependencies
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade

# Install GO
sudo rm -rf /usr/local/go
curl -Ls https://go.dev/dl/go1.21.0.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)

# Download and build binaries
mkdir -p $HOME/.zetacored/cosmovisor/genesis/bin
wget -O $HOME/.zetacored/cosmovisor/genesis/bin/zetacored https://github.com/zeta-chain/node/releases/download/v8.3.0/zetacored-ubuntu-22-amd64
chmod +x $HOME/.zetacored/cosmovisor/genesis/bin/zetacored

# Create application symlinks
sudo ln -s $HOME/.zetacored/cosmovisor/genesis $HOME/.zetacored/cosmovisor/current -f
sudo ln -s $HOME/.zetacored/cosmovisor/current/bin/zetacored /usr/local/bin/zetacored -f

# Install Cosmovisor and create a service
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0

# Create service
sudo tee /etc/systemd/system/zetacored.service > /dev/null << EOF
[Unit]
Description=zetachain node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.zetacored"
Environment="DAEMON_NAME=zetacored"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.zetacored/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable zetacored

# Initialize the node
zetacored config chain-id athens_7001-1
zetacored config keyring-backend test
zetacored config node tcp://localhost:16057
zetacored init $MONIKER --chain-id athens_7001-1

# Download genesis and addrbook
curl -Ls https://snapshots.kjnodes.com/zetachain-testnet/genesis.json > $HOME/.zetacored/config/genesis.json
curl -Ls https://snapshots.kjnodes.com/zetachain-testnet/addrbook.json > $HOME/.zetacored/config/addrbook.json

# Add seeds
sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@zetachain-testnet.rpc.kjnodes.com:16059\"|" $HOME/.zetacored/config/config.toml

# Set minimum gas price
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0azeta\"|" $HOME/.zetacored/config/app.toml

# Set pruning
sed -i -e 's|^pruning *=.*|pruning = "nothing"|' $HOME/.zetacored/config/app.toml

# Set custom ports
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:16058\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:16057\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:16060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:16056\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":16066\"%" $HOME/.zetacored/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:16017\"%; s%^address = \":8080\"%address = \":16080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:16090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:16091\"%; s%:8545%:16045%; s%:8546%:16046%; s%:6065%:16065%" $HOME/.zetacored/config/app.toml

# Download and build upgrade binaries
mkdir -p $HOME/.zetacored/cosmovisor/upgrades/v9.0.0/bin
wget -O $HOME/.zetacored/cosmovisor/upgrades/v9.0.0/bin/zetacored https://github.com/zeta-chain/node/releases/download/v9.0.0/zetacored-ubuntu-22-amd64
chmod +x $HOME/.zetacored/cosmovisor/upgrades/v9.0.0/bin/*

# Stop the service and reset the data
sudo systemctl stop zetacored
cp $HOME/.zetacored/data/priv_validator_state.json $HOME/.zetacored/priv_validator_state.json.backup
rm -rf $HOME/.zetacored/data

# Download latest snapshot
curl -L https://snapshots.kjnodes.com/zetachain-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.zetacored
mv $HOME/.zetacored/priv_validator_state.json.backup $HOME/.zetacored/data/priv_validator_state.json

# Restart the service and check the logs
sudo systemctl start zetacored && sudo journalctl -u zetacored -f --no-hostname -o cat

# Stop the service and reset the data
sudo systemctl stop zetacored
cp $HOME/.zetacored/data/priv_validator_state.json $HOME/.zetacored/priv_validator_state.json.backup
zetacored tendermint unsafe-reset-all --keep-addr-book --home $HOME/.zetacored

# Get and configure the state sync information
STATE_SYNC_RPC=https://zetachain-testnet.rpc.kjnodes.com:443
STATE_SYNC_PEER=d5519e378247dfb61dfe90652d1fe3e2b3005a5b@zetachain-testnet.rpc.kjnodes.com:16056
LATEST_HEIGHT=$(curl -s $STATE_SYNC_RPC/block | jq -r .result.block.header.height)
SYNC_BLOCK_HEIGHT=$(($LATEST_HEIGHT - 1000))
SYNC_BLOCK_HASH=$(curl -s "$STATE_SYNC_RPC/block?height=$SYNC_BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i \
  -e "s|^enable *=.*|enable = true|" \
  -e "s|^rpc_servers *=.*|rpc_servers = \"$STATE_SYNC_RPC,$STATE_SYNC_RPC\"|" \
  -e "s|^trust_height *=.*|trust_height = $SYNC_BLOCK_HEIGHT|" \
  -e "s|^trust_hash *=.*|trust_hash = \"$SYNC_BLOCK_HASH\"|" \
  -e "s|^persistent_peers *=.*|persistent_peers = \"$STATE_SYNC_PEER\"|" \
  $HOME/.zetacored/config/config.toml

mv $HOME/.zetacored/priv_validator_state.json.backup $HOME/.zetacored/data/priv_validator_state.json

# Restart the service and check the logs
sudo systemctl start zetacored && sudo journalctl -u zetacored -f --no-hostname -o cat

EOF

# Mengatur izin eksekusi pada file baru
chmod +x zeta.sh

# Menjalankan skrip yang baru dibuat
./zeta.sh
