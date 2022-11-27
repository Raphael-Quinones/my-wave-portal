// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave{
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    //records of people who waved
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
        //generate random seed or number
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        uint256 prizeAmount = 0.0001 ether;

        //Make sure it's 15 minutes 
        require(
            lastWavedAt[msg.sender] + 5 seconds < block.timestamp,
            "Wait 15m"
        );

        //update timestamp for current user
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves+=1;
        console.log("%s has waved with message: %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));
        
        //seed for next wave
        seed = (block.timestamp + block.difficulty) % 100;
        console.log("Random # generated: %d", seed);

        if (seed < 50) {
            console.log("%s has won!", msg.sender);

            //check if contract has enough money for withdrawal
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from the contract.");
        }


        emit NewWave(msg.sender, block.timestamp, _message);

    }

    function getAllWaves() public view returns(Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns(uint256){
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
}