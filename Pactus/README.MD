<p align="center">
  <img src="https://pactus.org/assets/images/logos/text_logo.png" alt="Pactus Logo">
</p>

<p align="center">
  <a href="https://discord.com/invite/H5vZkNnXCu">Discord</a> |
  <a href="https://twitter.com/pactuschain">Twitter</a> |
  <a href="https://pactus.org/user-guides/">Docs</a> |
  <a href="https://pactusscan.com/">Explorer</a>
</p>

# Pactus: Validator Installation On Linux Ubuntu 20.04 LTS

## Pactus Description

Pactus is a decentralized blockchain platform that aims to create a user-friendly ecosystem by eliminating centralization and manipulation. It utilizes a percentage-based fee model, offers dedicated decentralized storage, and focuses on simplicity and accessibility for all users.

## Minimum Spec Hardware :
NODE  | CPU     | RAM      | SSD     | OS     |
| ------------- | ------------- | ------------- | -------- | -------- |
| Pactus | 2          | 4         | 250  | Ubuntu 20.04 LTS  |

## Installation

1. **UPDATE**
	```
	sudo apt update; sudo apt upgrade
	```
2. **INSTALL DOCKER AND OTHER DEPENDENCIES**
	```
	sudo apt-get update && sudo apt install jq git && sudo apt install apt-transport-https ca-certificates curl software-properties- common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
	```
3. **DOWNLOAD PACTUS IMAGE**
	```
	docker pull pactus/pactus
	```
4. **RUN DOCKER CONTAINER:**
	```
	docker run -it --rm -v ~/pactus/testnet:/pactus pactus/pactus init -w /pactus --testnet
	```
5. **RUN NODE**
	```
	docker run -it -v ~/pactus/testnet:/pactus -p 8080:8080 -p 21777:21777 --name pactus-testnet pactus/pactus start -w /pactus
	```
## Useful Commands
- **STOP NODE**
	```
	docker stop pactus-testnet 
	```
- **START NODE**
	```
	docker start pactus-testnet 
	```
- **CHECK NODE LOGS**
	```
	docker logs pactus-testnet --tail 1000 -f
	```
## CHECK

- **BALANCE FAUCET**
[https://pactusscan.com/validator/[wallet-validator]](https://pactusscan.com/validator/[wallet-validator])

- **BALANCE REWARD**
[https://www.pactusscan.com/account/[wallet-reward]](https://www.pactusscan.com/account/[wallet-reward])
