// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MessageWall {
    uint256 messageCount;
    constructor() {
        console.log("Hey, Smart Contract. How you doing ?");
    }
    function incrementMessageCount() public {
        messageCount += 1;
        console.log("%s pinged you!", msg.sender);
    }

    function getTotalMessageCount() public view returns (uint256) {
        console.log("We have %d total messages!", messageCount);
        return messageCount;
    }
}
