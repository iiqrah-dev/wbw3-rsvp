const hre = require("hardhat");

const main = async () => {
  // use hardhat (hre) to deploy contract locally
  const contractFactory = await hre.ethers.contractFactory("Web3RSVP");
  const contract = await contractFactory.deploy();
  contract.deployed();
  console.log("Contract deployed to: ", contract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
