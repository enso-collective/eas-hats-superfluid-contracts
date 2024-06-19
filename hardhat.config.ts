import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.25",
  networks: {
    base: {
      chainId: 8453,
      url: `<BASE_RPC_URL>`,
      accounts: [`<PRIVATE_KEY>`],
    },
  },
  // @ts-ignore
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  defaultNetwork: "base",
};

export default config;
