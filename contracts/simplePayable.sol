// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimplePayable {

    address public owner;

    event Deposit(address indexed sender, uint256 amount, uint256 contractBalance);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    fallback() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    function deposit() external payable returns (bool) {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        emit Deposit(msg.sender, msg.value, address(this).balance);
        return true;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdrawAll() external onlyOwner {
        uint256 balance = address(this).balance;
        (bool sent, ) = owner.call{value: balance}("");
        require(sent, "Failed to send Ether");
    }

    function withdrawTo(address recipient, uint256 amount) external payable  onlyOwner {
        require(recipient != address(0), "Recipient cannot be zero address");
        require(amount > 0, "Amount must be greater than zero");
        require(address(this).balance >= amount, "Insufficient contract balance");

        (bool sent, ) = recipient.call{value: amount}("");
        require(sent, "Transfer failed");
    }
}