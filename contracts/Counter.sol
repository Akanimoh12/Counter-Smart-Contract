// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{
    uint public count;
    address public owner;

    constructor ()  {
        owner  = msg.sender;
    }

    event countChanged(address indexed sender, uint _count, string changed);

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }


    function increment() external {  // function name is "increment"
        count++; 
        emit countChanged(msg.sender,count,"incremented");
                      // increments the counter value by one (as we are doing in memory)
    }

    function decrement() external {
        count --;
    }
    function getCount() external view returns (uint) {
       return count;   // returning current value of the counter
    }

    function setCount (uint _count) external {
        count = _count;
    }
}




// pragma solidity ^0.8.17;

// contract Counter {
//     uint256 public counterNumb;
//     address public owner;

//     constructor(uint256 _initialValue) {
//         owner = msg.sender;
//         counterNumb = _initialValue;
//     }

//     event NumberChanged(address indexed changer, uint256 newValue, string action);

//     modifier onlyOwner() {
//         require(msg.sender == owner, "Only owner can modify counter");
//         _;
//     }


//     function increaseNumb() public onlyOwner returns (uint256) {
//         counterNumb++;
//         emit NumberChanged(msg.sender, counterNumb, "increased");
//         return counterNumb;
//     }

//     function decreaseNumb() public onlyOwner returns (uint256) {
//         counterNumb--;
//         emit NumberChanged(msg.sender, counterNumb, "decreased");
//         return counterNumb;
//     }

//     function getStoredNumber() public view returns (uint256) {
//         return counterNumb;
//     }

//     // function transferOwnership(address newOwner) public onlyOwner {
//     //     owner = newOwner;
//     // }
// }