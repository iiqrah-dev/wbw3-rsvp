const hre = require("hardhat");

const main = async () => {
  // use hardhat (hre) to deploy contract locally
  const rsvpcontractFactory = await hre.ethers.getContractFactory("Web3RSVP");
  const rsvpcontract = await rsvpcontractFactory.deploy();
  rsvpcontract.deployed();
  console.log("Contract deployed to: ", rsvpcontract.address);

  // get addresses from hardhat to test contract functionality
  const [deployer, add1, add2] = await hre.ethers.getSigners();

  // Declare and assign values needed for createEvent() function call
  let eDataCID = "bafybeibhwfzx6oo5rymsxmkdxpmkfwyvbjrrwcl7cekmbzlupmp5ypkyfi";
  let eTimeStart = 1718926200;
  let eCapacity = 25;
  let eDepositAmount = hre.ethers.utils.parseEther("1");

  // call contract function as an await transaction
  let txn = await rsvpcontract.createEvent(
    eDataCID,
    eTimeStart,
    eCapacity,
    eDepositAmount
  );
  // log all the data from createEvent() function call inside wait
  let wait = await txn.wait();
  // print the contents that we get back from createEvent() function call
  // console.log("New event created: ", wait);

  // print the data that is sent back from emit event after functional call
  // console.log(wait.events[0].args);

  // print eventID
  let eID = wait.events[0].args.eID;
  console.log("Event ID: ", eID);

  // call addNewRegistrant() function as a contract transaction
  txn = await rsvpcontract.addNewRegistrant(eID, { value: eDepositAmount });
  wait = await txn.wait();
  console.log(wait.events[0].args);

  // // call addNewRegistrant with same address to check failure
  // txn = await rsvpcontract.addNewRegistrant(eID, { value: eDepositAmount });
  // wait = await txn.wait();
  // // console.log(wait.events[0].args);

  // call addNewRegistrant with adddress1
  txn = await rsvpcontract
    .connect(add1)
    .addNewRegistrant(eID, { value: eDepositAmount });
  wait = await txn.wait();
  console.log(wait.events[0].args);

  // call addNewRegistrant with adddress2
  txn = await rsvpcontract
    .connect(add2)
    .addNewRegistrant(eID, { value: eDepositAmount });
  wait = await txn.wait();
  console.log(wait.events[0].args);

  // call checkInAllRegistrants()
  txn = await rsvpcontract.checkInAllRegistrants(eID);
  wait = await txn.wait();
  console.log(wait.events);
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
