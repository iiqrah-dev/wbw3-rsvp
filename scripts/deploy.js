const hre = require("hardhat");

const main = async () => {
  // use hardhat (hre) to deploy contract locally
  const rsvpcontractFactory = await hre.ethers.getContractFactory("Web3RSVP");
  const rsvpcontract = await rsvpcontractFactory.deploy();
  rsvpcontract.deployed();
  console.log("Contract deployed to: ", rsvpcontract.address);
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
