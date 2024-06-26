# Steps for running repo

## 1 - Compile contracts with hardhat compile

## 2 - Setup hardhat config

```
networks: {

base: {

chainId:  8453,

url:  `<BASE_RPC_URL>` //Replace with provider RPC url,

accounts: [`<PRIVATE_KEY>` //Replace with Private key],

},

},
```

## 3 - Deploy FlowSender contract

    npx hardhat run scripts/deployFlowSender.ts

Make sure to copy the address of the contract after deployment, it will be necessary for the next steps.

Note - This contract uses the super bento token. Can set it up to use any other super token however.

## 4 - Send some (at least 10,000) Bento (or other ERC-20) tokens to the contract address from the deployment above

## 5 - Run `gainSuperToken` script

`npx hardhat run scripts/gainSuperToken.ts`
Replace `flowSenderAddress` in the script with the address of the contract deployed in step 3

## 6 - Create hat and configure hat properties

Copy the contract address from above and replace the `streamSenderAddress` in the `AttesterResolver.sol` contract with it, then replace `hatId` in the same file with your hat ID

## 7 - Deploy AttesterResolver contract

`npx hardhat run scripts/deployResolver.ts`
Make sure to copy the contract address after deployment, you'll need it for the next step.

## 8 - Run `grantPermission` script

`npx hardhat run scripts/grantPermission.ts`
Make sure to replace the `flowSenderAddress` with the address of the contract deployed in step 3. And replace `recipientAddress` with address of contract deployed in step 7

## 9 - Grant automatic permission to revoke hats to the attesterResolver contract deployed in step 7, also make sure to transfer admin hat to the same contract address

## 10 - he attesterResolver contract address deployed in step 7 as the EAS resolver contract address
