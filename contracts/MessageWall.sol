// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MessageWall {
    uint256 messageCount;
    uint256 private randomValue;
    mapping(address => uint256) public lastMessagedAt;
    event NewMessage(string message, address indexed from, uint256 timestamp);
    struct Message{
        string message; // The message
        address sender; // The address of the sender who sent the message.
        uint256 timestamp; // The timestamp
    }
    Message[] messages;

    constructor() payable {
        randomValue = (block.timestamp + block.difficulty) % 100;
    }

    function setMessage(string memory _message) public {
        require(
            lastMessagedAt[msg.sender] + 5 minutes < block.timestamp,
            "Rate Limit(5 minutes)"
        );
        lastMessagedAt[msg.sender] = block.timestamp;
        messageCount += 1;
        messages.push(Message(_message, msg.sender, block.timestamp));
        randomValue = (block.difficulty + block.timestamp + randomValue) % 100;
        console.log("%d Random Value", randomValue);
        if(randomValue > 50){
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        emit NewMessage(_message, msg.sender, block.timestamp);
    }

    function getTotalMessageCount() public view returns (uint256) {
        return messageCount;
    }

    function getMessages() public view returns (Message[] memory) {
        return messages;
    }
}
