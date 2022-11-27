// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave{
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function wave(string memory _message) public {
        uint256 prizeAmount = 0.0001 ether;

        totalWaves+=1;
        console.log("%s has waved with message: %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        // Check if contract has funds to execute withdrawal
        require(
            prizeAmount <= 0.0001 ether,
            "Trying to withdraw more money than the contract has."
        );
        //Send money to waver
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");  
    }

    function getAllWaves() public view returns(Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns(uint256){
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
}