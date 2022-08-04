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


}