// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Web3RSVP{

    // be picky about the data you store on-chain as it is expensive!
    // eDataCID to store event name, description etc
    // only store data that is required for on-chain functionality 
    struct Event{

        // unique event identifier
        bytes32 eID;
        // unique event content-identifier
        string eDataCID;
        // address of person creating the event
        address eCreator;
        // timestamp of when event starts
        uint256 eTimeStart;
        // maximum capacity for event registrants
        uint256 eCapacity;
        // amount to be deposited by each registrant
        uint256 eDepositAmount;
        // array to store addresses of everyone that registers
        address[] eRegistrants;
        // array to store addresses of registrants that check-in and attend the event
        address[] eAttendees;
        // to check if deposited amlont is paid or not
        bool isPaid;
    }


    // link an eID to an Event struct using mapping
    mapping(bytes32 => Event) public idToEventMapping;

    // Create function to add an event
    // data passed my front-end: event data CID, start time, capacity, deposit amount
    function createEvent(string calldata eDataCID, uint256 eTimeStart, uint256 eCapacity, uint256 eDepositAmount) external{
        // eID generated usisng keccak256 hashing with a bunch of things
        bytes32 eID = keccak256(abi.encodePacked(msg.sender, address(this), eTimeStart, eCapacity, eDepositAmount ));
        // set eCreator with address of whoever called this function   
        address eCreator = msg.sender;
        // Initialise array and bool for struct creation
        address[] memory eRegistrants;
        address[] memory eAttendees;
        bool isPaid = false;

        // uses mapping to map and create struct when this function is called
        idToEventMapping[eID] = Event(eID, eDataCID, eCreator, eTimeStart, eCapacity, eDepositAmount, eRegistrants, eAttendees, isPaid);
    }

    // Create function to add registrants by using eID to identify which event they want to get added to
    // Make it payable as ETH is required to put as stake to register
    function addRegistrant(bytes32 eID) external payable{

        // use eID to check Event mapping and get that struct for this function
        Event storage thisEvent = idToEventMapping[eID];

        // Check if event has started yet?
        require(block.timestamp < thisEvent.eTimeStart, 'Too late to register');

        // Check if event capacity is reached yet?
        require(thisEvent.eRegistrants.length < thisEvent.eCapacity, 'Max capacity reached');

        // Check if registrant has enough ETH?
        require(msg.value == thisEvent.eDepositAmount, 'Not enough ETH to proceed');

        // Check if registrant already registered previously? 
        for (uint8 i = 0; i < thisEvent.eRegistrants.length; i++){
            require( thisEvent.eRegistrants[i] != msg.sender, 'You are already registered!');
        }

        // After all checks, push the registrant's address to the required array
        thisEvent.eRegistrants.push(payable(msg.sender));

        // How does the contract know how much ETH to use?
        // If we have 1000s of registrants, wouldn't a for loop be slow?
        // Should there be a mechanism in place to check if eID passed exists? 
        
    }


}