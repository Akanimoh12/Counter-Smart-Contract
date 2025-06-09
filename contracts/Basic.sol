// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reference {
    struct Class {
        address addr;
        uint age;
        uint time;
        bool overEighteen;
    }

    function setClass(address _addr, uint _age, uint _time, bool _overEighteen) public pure returns(Class memory) {
        
        return Class(_addr, _age, _time, _overEighteen);
    }

    // fixed array size
    uint[5] participants = [1,2,3,4,5];

    function getSum() public pure returns (uint)  {


        uint[] memory s = new uint[](5);

        s[0] = 1;
        s[1] = 2;
        s[2] = 3;
        s[3] = 4;
        s[4] = 5;

        uint sum;

        for (uint i=0; i < s.length; i++) 
        {
            sum += s[1];
        }
        return sum;
    }

    // mapping
    mapping (address => uint) balances;

    function deposit(address _addr, uint _val) public  {
        balances[_addr] = _val;
    }
    
}