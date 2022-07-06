require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    hardhat: {
      gas: 12000000,
      blockGasLimit: 0x1fffffffffffff,
      allowUnlimitedContractSize: true,
      timeout: 1800000
    },
    rinkeby: {
      gas: 12000000,
      url: process.env.RINKEBY_HTTP_INFURA || '',
      accounts: {
        mnemonic: process.env.MNEMONICS,
      },
      chainId: 4,
      minGasPrice: 42000000000000,
    },
    ropsten: {
      gas: 12000000,
      minGasPrice: 42000000000000,
      url: process.env.ROPSTEN_HTTP_INFURA || '',
      accounts: {
        mnemonic: process.env.MNEMONICS,
      },
      chainId: 3,
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  }
};
