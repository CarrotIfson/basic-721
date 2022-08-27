require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.2"
      }
    ]
  },
  networks: {
      mumbai: { 
        url: "https://rpc-mumbai.maticvigil.com",
        accounts: [process.env.PRIV_KEY],
        gasPrice: 10000000000,
        blockGasLimit: 10000000
      }
  }
  //defaultNetwork: "bsctest",
}; 