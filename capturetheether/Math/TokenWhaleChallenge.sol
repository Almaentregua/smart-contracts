pragma solidity ^0.4.21;

contract TokenWhaleChallenge {
    address player;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    string public name = "Simple ERC20 Token";
    string public symbol = "SET";
    uint8 public decimals = 18;

    function TokenWhaleChallenge(address _player) public {
        player = _player;
        totalSupply = 1000;
        balanceOf[player] = 1000;
    }

    function isComplete() public view returns (bool) {
        return balanceOf[player] >= 1000000;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);

    function _transfer(address to, uint256 value) internal {
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
    }

    function transfer(address to, uint256 value) public {
        require(balanceOf[msg.sender] >= value);
        require(balanceOf[to] + value >= balanceOf[to]);

        _transfer(to, value);
    }

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function approve(address spender, uint256 value) public {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
    }

    function transferFrom(address from, address to, uint256 value) public {
        require(balanceOf[from] >= value);
        require(balanceOf[to] + value >= balanceOf[to]);
        require(allowance[from][msg.sender] >= value);

        allowance[from][msg.sender] -= value;
        _transfer(to, value);
    }
}


/*
The bug is in transferFrom. It discount the token fron the sender instead of the address "from". To exploit the problem one posibility is:

1. You neet 2 wallet. One is the used in "player". The other (walletSecundary) doesn't have tokens.
2. You have to call with the wallet player to the function approve. The argument are: walletSecundary and the value 1
3. You have to call with the wallet walletSecundary to the function transferFrom. The argument are: The wallet player, The wallet player again, and the value 1.
   When the jvm ejecute the line 34, it will do the operation 0 - 1, and the result will be 2^256 becouse uint doesn't have negative integers
4. The last thing is transfer 1000000 tokens from the walletSecundary to the wallet player using the function transfer.
*/