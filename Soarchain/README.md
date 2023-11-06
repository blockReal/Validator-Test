<p align="center">
  <img src="https://pbs.twimg.com/profile_images/1681943775612993536/g2zgtZ53_400x400.jpg" alt="Soarchain Logo">
</p>

<p align="center">
  <a href="https://www.soarchain.com/=">Official</a> |
  <a href="https://twitter.com/soar_chain">Twitter</a> |
  <a href="https://twitter.com/soar_chain">Discord</a> |
  <a href="https://github.com/soar-robotics">Github</a> |
  <a href="https://www.blog.soarchain.com">Medium</a> | 
  <a href="https://docs.soarchain.com/category/validator">Docs</a>
</p>


<p align="center">
  <h1>Soarchain Installation</h1>
</p>

## Farcaster Description
Soarchain, a Layer 1 network, enables an ecosystem where developers can leverage data a car produces each day

## Minimum Spec Hardware
NODE  | CPU     | RAM      | SSD     | OS     |
| ------------- | ------------- | ------------- | -------- | -------- |
| SOAR | 8          | 16         | 250  | Ubuntu 20.04 LTS  |

## Installation

1. **Auto Install**
	```
        wget -O autoinstall.sh  https://raw.githubusercontent.com/blockReal/Validator-Test/main/Soarchain/autoinstall.sh && chmod +x autoinstall.sh && ./autoinstall.sh
	```
2. **Initialize Wallet**
	```
	soarchaind keys add KEY_NAME
	```
	```
	soarchaind keys list
	```
3. **Validator Public Key**
	```
    soarchaind tendermint show-validator
	```
4. **Create Validator**
	```
	soarchaind tx staking create-validator \
	--from=wallet \
	--amount=500000000motus \
	--pubkey=$(soarchaind tendermint show-validator)  \
	--moniker="your_moniker" \
	--chain-id="soarchaintestnet" \
	--commission-rate="0.1" \
	--commission-max-rate="0.2" \
	--commission-max-change-rate="0.05" \
	--min-self-delegation="500000000" \
	--gas="auto" \
	--gas-prices="0.0025motus"
	```
5. **Update**
	```
	SOON
	```
