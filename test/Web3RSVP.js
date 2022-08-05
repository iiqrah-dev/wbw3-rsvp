const hre = require("hardhat");

const main = async () => {
  // use hardhat (hre) to deploy contract locally
  const contractFactory = await hre.ethers.contractFactory("Web3RSVP");
  const contract = await contractFactory.deploy();
  contract.deployed();
  console.log("Contract deployed to: ", contract.address);

  // get addresses from hardhat to test contract functionality
  const [deployer, add1, add2] = hre.ethers.getSigners();
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
