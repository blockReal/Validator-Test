<p align="center">
  <img src="https://pbs.twimg.com/profile_images/1546487688601096192/QoG0ZVgH_400x400.jpg" alt="Farcaster Logo">
</p>

<p align="center">
  <a href="https://www.farcaster.xyz/">Official</a> |
  <a href="https://twitter.com/farcaster_xyz">Twitter</a> |
  <a href="https://github.com/farcasterxyz/protocol">Docs</a> |
</p>

<p align="center">
  <h1>Farcaster Installation</h1>
</p>

## Farcaster Description
Farcaster is a community-created protocol for building decentralized social applications.

Developers can use Farcaster to build new, decentralized social networks, letting the protocol deal with the hard problems of managing user identities and data. Users can create a new account that they control and sign up to use any of these applications. Users are always in control of their data and identity and can switch freely between applications.

## Minimum Spec Hardware
NODE  | CPU     | RAM      | SSD     | OS     |
| ------------- | ------------- | ------------- | -------- | -------- |
| Farcaster | 2          | 8         | 20  | Ubuntu 20.04 LTS  |

## Installation
Prepare Open Port 

1. **Update**
	```
	sudo apt update; sudo apt upgrade
	```
2. **Install Docker & Dependencies**
	```
	sudo apt-get update && sudo apt install jq git && sudo apt install apt-transport-https ca-certificates curl software-properties- common -y && curl -fsSL 
        https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo 
        apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
	```
3. **Open Port**
	```
	sudo ufw allow 8545
	sudo ufw allow 2282
 	sudo ufw allow 2283 
	```
4. **Clone Repository**
	```
	git clone https://github.com/farcasterxyz/hub-monorepo.git
	```
5. **Create hub identity**
	```
	cd apps/hubble
	```
 	```
	docker compose run --rm hubble yarn identity create
	```
6. **Create Endpoint `Goerli Ethereum`**
	- <a href="https://www.infura.io/">`Infura`</a>
   OR
	- <a href="https://www.alchemy.com/">`Alchemy`</a>

7. **Create a `.env` file in `apps/hubble` directory**
	```
	ETH_RPC_URL=your-ETH-RPC-URL
	FC_NETWORK_ID=2
	BOOTSTRAP_NODE=/dns/testnet1.farcaster.xyz/tcp/2282
	```
8. **Run**
	```
	docker compose up hubble
	```
9. **Verify**
   	 ```
	0 | hubble | { level: 30, time: 1679703063660, pid: 3259, hostname: 'ip-10-0-0-85', component: 'EthEventsProvider', blockNumber: 8712752, msg: 'new block: 8712752 };

	0 | hubble | { level: 30, time: 1679702496763, pid: 3259, hostname: 'ip-10-0-0-85', component: 'SyncEngine', total: 1, success: 1, msg: 'Merged messages', };
   	 ```
10. **Monitor Status**
	```
	docker compose exec hubble yarn status --watch --insecure
	```
