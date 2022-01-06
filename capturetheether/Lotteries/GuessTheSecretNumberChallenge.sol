pragma solidity ^0.4.21;

contract GuessTheSecretNumberChallenge {
    bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;

    function GuessTheSecretNumberChallenge() public payable {
        require(msg.value == 1 ether);
    }
    
    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);

        if (keccak256(n) == answerHash) {
            msg.sender.transfer(2 ether);
        }
    }
}


/*
We use brute force... The posibilities are between 0 and 255

pragma solidity ^0.4.21;

contract FindTheAnswer {
    bytes32 answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;

    function getTheAnswer() public view returns(uint8) {
        uint8 val = 0;
        while(val <= 255) {
            if (keccak256(val) == answerHash) {
                return val;
            }
            val+=1;
        }
        return 0;
    }

}

The answer is 170
*/