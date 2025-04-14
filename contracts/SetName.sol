// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SetName {
    string public name = 'Akanimoh';

    mapping (uint32 => string MyName ) namesTaken;

    // create a function where user setName(), getName(), resetName()

    function setName(string memory _name) public {
        name = _name;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function resetName() public {
        name = 'Johnson';
    }
}

