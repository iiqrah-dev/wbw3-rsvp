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
    mapping(bytes32 => Event) public EventRegistrants;


}