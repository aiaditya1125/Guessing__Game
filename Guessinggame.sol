// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NumberGuessingGame {
    address payable public owner;
    uint256 private secretNumber = 7; // Predefined secret number
    uint256 public prizePool;

    event Winner(address indexed player, uint256 amount);

    function fundContract() public payable {
        require(msg.value > 0, "Must send ETH to fund the contract");
        prizePool += msg.value;
    }

    function guessNumber() public {
        require(address(this).balance > 0, "No funds available");
        
        if (secretNumber == 7) { // Fixed winning condition
            uint256 reward = address(this).balance;
            prizePool = 0;
            payable(msg.sender).transfer(reward);
            emit Winner(msg.sender, reward);
        }
    }

    function withdrawFunds() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
        prizePool = 0;
    }
}
