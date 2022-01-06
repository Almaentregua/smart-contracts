pragma solidity ^0.4.21;

contract GuessTheRandomNumberChallenge {
    uint8 answer;

    function GuessTheRandomNumberChallenge() public payable {
        require(msg.value == 1 ether);
        answer = uint8(keccak256(block.blockhash(block.number - 1), now));
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}


/*

1. First we have to deploy the contract in the red.
2. We have to get the block.timestamp (is "now" in the code). In mi case the block was https://ropsten.etherscan.io/block/11746393 
and the timestamp was Jan-03-2022 08:44:05 PM +UTC. We have to translate that date to the epoc time. We can use this page for that
motive https://www.epochconverter.com/ (EPOCTIME)
3. We have to get the hash of the block before. In mi case the block was 11746393, so I search in the block before the hash
 https://ropsten.etherscan.io/block/11746393 (HASH)
4. With the 2 values we can obtain the value in remix. The code could be like this:


pragma solidity ^0.4.21;

contract GuessTheRandomNumberChallengeFake {
 
    function dame() public pure returns(uint8) {
        return uint8(keccak256(bytes32(HASH),uint256(EPOCTIME)));
    }
}

5. When you obtaine the number, only need consume the function guest() with it

This contract help me to undestand the concepts:

pragma solidity ^0.4.21;

contract Help {
    bytes32 public blockhashh;
    uint256 public noww;
    uint256 public bloque;

    function Help() public payable {
        blockhashh = block.blockhash(block.number - 1);
        noww = now;
        bloque = block.number;
    }
}

Some theory here:

https://docs.soliditylang.org/en/v0.4.24/units-and-global-variables.html

*/
