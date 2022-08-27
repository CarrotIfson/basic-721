const { ethers } = require("hardhat");
//const { Config } = require("./config.ts");

async function main() {
  //await Config.initConfig();

  const network = hardhatArguments.network ? hardhatArguments.network : 'mumbai';
  const [deployer] = await ethers.getSigners();
  console.log('deployer address: ', deployer.address);

  const TheShire = await ethers.getContractFactory("TheShireInhabitants");
  const theShire = await TheShire.deploy("theShire","SHR");
  await theShire.deployed();
  console.log('Deployed theShire on: ', theShire.address);

  //MINT FRODO
  await theShire.mint('https://ipfs.io/ipfs/QmVaazt9FTKSHrjigcRNLMuSrEKTqMQ4uQ52a2i5YAck2t');
  console.log('Minted Frodo');
  //MINT SAM
  await theShire.mint('https://ipfs.io/ipfs/Qmeb69k4wBheZQFSnNVCbGj83C3bK1utUmgx3dqry8KreS');
  console.log('Minted SAM');

  //Config.setConfig(network + '.theShire', theShire.address);
  //await Config.updateConfig(); 
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
/*
import { ethers, hardhatArguments } from "hardhat";
import  * as Config from "./config";
 
async function main() {
  await Config.initConfig();
  const network = hardhatArguments.network ? hardhatArguments.network : 'mumbai';
  const [deployer] = await ethers.getSigners();
  console.log('deployer address: ', deployer.address);

  const Floppy = await ethers.getContractFactory("Floppy");
  const floppy = await Floppy.deploy();
  console.log('Deployed Floppy on: ', floppy.address);
  Config.setConfig(network + '.Floppy', floppy.address); 


  const Vault = await ethers.getContractFactory("Vault");
  const vault = await Vault.deploy();
  console.log("Deployed Vault on: ", vault.address);
  Config.setConfig(network + '.Vault', vault.address);
  await Config.updateConfig();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
*/