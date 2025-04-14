// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypes {
    uint[] numbers = [1,2,3,4,5,6,7];

    function getNumbers(uint newArray) public returns (uint[] memory) {
        // uint[] newArray = [12,4,6,9]; 
        numbers.push(newArray);
        return numbers;
    }
}