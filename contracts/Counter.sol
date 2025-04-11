// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Counter {
    uint256 private counterNumb;
    address public owner;

    constructor(uint256 _initialValue) {
        owner = msg.sender;
        counterNumb = _initialValue;
    }

    event NumberChanged(address indexed changer, uint256 newValue, string action);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can modify counter");
        _;
    }


    function increaseNumb() public onlyOwner returns (uint256) {
        counterNumb++;
        emit NumberChanged(msg.sender, counterNumb, "increased");
        return counterNumb;
    }

    function decreaseNumb() public onlyOwner returns (uint256) {
        counterNumb--;
        emit NumberChanged(msg.sender, counterNumb, "decreased");
        return counterNumb;
    }

    function getStoredNumber() public view returns (uint256) {
        return counterNumb;
    }

    // function transferOwnership(address newOwner) public onlyOwner {
    //     owner = newOwner;
    // }
}