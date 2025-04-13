// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypes {
    uint[] numbers = [1,2,3,4,5];

    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }
}