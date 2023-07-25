//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint256 timeStamp,
        string name,
        string message
    );
   struct Memo {
       address from;
       uint256 timeStamp;
       string name;
       string message;
   }
    Memo[] memos;

   address payable owner;
    constructor(){
        owner = payable (msg.sender);
    }
    function buyCoffee(string memory _name , string memory _message) public payable {
        require(msg.value > 0,"Cant Buy Coffe with 0 ETH");

        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }
    function withdrawTips()public{
        require(owner.send(address(this).balance));
    }
    function getMemos()public view returns(Memo[] memory) {
        return memos;
    }
}
