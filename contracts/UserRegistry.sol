// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserRegistry {
    address public owner;

    struct UserInfo {
        string name;
        uint age;
        string class;
        uint studentId;
        bool isRegistered;
    }

    mapping(uint => UserInfo) public users;

    function addUser(string memory _name, uint _id, uint _age, string memory _class, uint _studentId, bool _isRegistered) public {
        users[_id] = UserInfo(_name, _age, _class, _studentId, _isRegistered);
    }

    function updateUser(string memory _name, uint _id, uint _age, string memory _class, uint _studentId, bool _isRegistered) public {
        users[_id] = UserInfo(_name, _age, _class, _studentId, _isRegistered);
    }

    function getAllStudentById(uint _id) public  view returns (UserInfo memory) {
        return users[_id];
    }

    function getAllRegisteredStudent() public  view returns (UserInfo[] memory) {
        return users;
    }


}