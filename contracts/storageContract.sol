// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleStorage {
    uint private  storedNumber;

    event NumberStored(address indexed from, uint newNumber);

    function storeNumber(uint _number) public {
        storedNumber = _number;
        emit NumberStored(msg.sender,_number);
    }

    function getStoredNumber() public  view returns (uint) {
        return storedNumber;  
    }
}