// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    uint256 public price;
    
    address public owner; 

    constructor() {
        owner = msg.sender; // ketika contract dideploy ini bakal ke run pertama
    }

    function setPrice(uint256 newPrice) public {
        require(msg.sender == owner, "Only owner can set the price"); 
        price = newPrice;
    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
