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

<p align="center">
  <h4><span style="color: blue;">**Incentive Reward [confirm]**</span></h4>
</p>

## Farcaster Description
Farcaster is a community-created protocol for building decentralized social applications.

Developers can use Farcaster to build new, decentralized social networks, letting the protocol deal with the hard problems of managing user identities and data. Users can create a new account that they control and sign up to use any of these applications. Users are always in control of their data and identity and can switch freely between applications.

## Minimum Spec Hardware
NODE  | CPU     | RAM      | SSD     | OS     |
| ------------- | ------------- | ------------- | -------- | -------- |
| Farcaster | 2          | 8         | 15  | Ubuntu 20.04 LTS  |

## Installation

1. **Update**
	```
	sudo apt install curl git -y
	```
2. **Install Node**
	```
	curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
    source ~/.bashrc
	```
3. **Install Flatbuffers**
	```
	sudo apt update
	sudo apt install -y flatbuffers-compiler
	```
4. **Endpoint Goerli Ethereum**
- <a href="https://www.infura.io/">`Infura`</a>
   OR
- <a href="https://www.alchemy.com/">`Alchemy`</a>

5. **Open Port**
	```
	sudo ufw allow 8545
	```
6. **Clone Hubble**
	```
	git clone https://github.com/farcasterxyz/hubble.git
	```
7. **Build Hubble**
	```
	cd hubble && yarn install && yarn build
	```	
8. **Create a network identity**
	```
	cd app/hubble 
	```	
	```
	yarn identity create
	```	
9. **Start the Hub**
	```
	yarn start -e <eth-rpc-url> 
	```
