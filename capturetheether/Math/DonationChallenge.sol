pragma solidity ^0.4.21;

contract DonationChallenge {
    struct Donation {
        uint256 timestamp;
        uint256 etherAmount;
    }
    Donation[] public donations;

    address public owner;

    function DonationChallenge() public payable {
        require(msg.value == 1 ether);
        
        owner = msg.sender;
    }
    
    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function donate(uint256 etherAmount) public payable {
        // amount is in ether, but msg.value is in wei
        uint256 scale = 10**18 * 1 ether;
        require(msg.value == etherAmount / scale);

        Donation donation;
        donation.timestamp = now;
        donation.etherAmount = etherAmount;

        donations.push(donation);
    }

    function withdraw() public {
        require(msg.sender == owner);
        
        msg.sender.transfer(address(this).balance);
    }
}

/**

There are one bug between the lines 27 and 29. I don't understand why (I supouse its related with some overflow), but:

    * The line 27 update the size of the array Donations.
    * The line 29 update the variable owner.

The exploit is call the function "donate" with the address of the atacker. Also we need calculate the amount of wei that we have to send with that value. 
To do that I create a little function:

function mount(uint256 address) external pure returns(uint256) {
    uint256 scale = 10**18 * 1 ether;
    uint256 value = etherAmount / scale;
    return value;
}

The result of that function is the cant of wei that we have to sent to avoid th requiere of line 25.

I recomend the folloween video, that can help to understang a little the overflow:

https://www.youtube.com/watch?v=gUqHgFuSsqg&list=LL&index=1
 */