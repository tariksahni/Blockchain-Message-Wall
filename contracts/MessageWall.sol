// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MessageWall {
    uint256 messageCount;
    event NewMessage(string message, address indexed from, uint256 timestamp);
    struct Message{
        string message; // The message
        address sender; // The address of the sender who sent the message.
        uint256 timestamp; // The timestamp
    }
    Message[] messages;

    constructor() payable {}
    function setMessage(string memory _message) public {
        messageCount += 1;
        messages.push(Message(_message, msg.sender, block.timestamp));
        emit NewMessage(_message, msg.sender, block.timestamp);
        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getTotalMessageCount() public view returns (uint256) {
        return messageCount;
    }

    function getMessages() public view returns (Message[] memory) {
        return messages;
    }
}
