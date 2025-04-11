// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimplePayable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    receive() external payable {
        
    }

    fallback() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        (bool sent, ) = owner.call{value: balance}("");
        require(sent, "Failed to send Ether");
    }

    function withdrawTo(address recipient, uint256 amount) external onlyOwner {
        require(recipient != address(0), "Recipient cannot be zero address");
        require(amount > 0, "Amount must be greater than zero");
        require(address(this).balance >= amount, "Insufficient contract balance");

        (bool sent, ) = recipient.call{value: amount}("");
        require(sent, "Transfer failed");
    }
}