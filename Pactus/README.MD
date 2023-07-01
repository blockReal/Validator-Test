<p align="center">
  <img src="https://pactus.org/assets/images/logos/text_logo.png" alt="Pactus Logo">
</p>

<p align="center">
  <a href="https://discord.com/invite/H5vZkNnXCu">Discord</a> |
  <a href="https://twitter.com/pactuschain">Twitter</a> |
  <a href="https://pactus.org/user-guides/">Docs</a> |
  <a href="https://pactusscan.com/">Explorer</a>
</p>

<p align="center">
  <h1>Validator Installation On Linux Ubuntu 20.04 LTS</h1>
</p>

## Pactus Description
Pactus is a decentralized blockchain platform that aims to create a user-friendly ecosystem by eliminating centralization and manipulation. It utilizes a percentage-based fee model, offers dedicated decentralized storage, and focuses on simplicity and accessibility for all users.

## Minimum Spec Hardware
NODE  | CPU     | RAM      | SSD     | OS     |
| ------------- | ------------- | ------------- | -------- | -------- |
| Pactus | 2          | 4         | 250  | Ubuntu 20.04 LTS  |

## Installation

1. **Update**
	```
	sudo apt update; sudo apt upgrade
	```
2. **Install Docker & Dependemcies**
	```
	sudo apt-get update && sudo apt install jq git && sudo apt install apt-transport-https ca-certificates curl software-properties- common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
	```
3. **Download PACTUS Image**
	```
	docker pull pactus/pactus
	```
4. **Run Docker Container**
	```
	docker run -it --rm -v ~/pactus/testnet:/pactus pactus/pactus init -w /pactus --testnet
	```
5. **Save Seed & Input Password**

6. **Run Node**
	```
	docker run -it -v ~/pactus/testnet:/pactus -p 8080:8080 -p 21777:21777 --name pactus-testnet pactus/pactus start -w /pactus
	```
## Useful Commands
- **Stop Node**
	```
	docker stop pactus-testnet 
	```
- **Start Node**
	```
	docker start pactus-testnet 
	```
- **Check Logs**
	```
	docker logs pactus-testnet --tail 1000 -f
	```
## Check [Faucet can request to <a href="https://discord.com/invite/H5vZkNnXCu">Discord</a>]
- **Balance Faucet**
[https://pactusscan.com/validator/[wallet-validator]](https://pactusscan.com/validator/[wallet-validator])

- **Balance Reward**
[https://www.pactusscan.com/account/[wallet-reward]](https://www.pactusscan.com/account/[wallet-reward])

## Fix & Error
- **Error : Port is already in use**
	```
	docker rm pactus-testnet
	```
	```
	docker run -it -v ~/pactus/testnet:/pactus -p 8888:8080 -p 21777:21777 --name pactus-testnet pactus/pactus start -w /pactus
	```

- **Error : Exiced Code / Request Password**
	```
	docker rm pactus-testnet
	```
	```
	sudo apt-get install screen 
	```
	```
	screen -S 
	```
	```
	docker run -it -v ~/pactus/testnet:/pactus -p 8080:8080 -p 21777:21777 --name pactus-testnet pactus/pactus start -w /pactus
	```



