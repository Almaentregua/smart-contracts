// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = _totalSupply;
        emit Transfer(address(0x0), address(this), _totalSupply);
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0));
        //It's posible to skip this control if uses the 0.8 version of solidity. Also you can use
        //openzepelling to minor versions https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol 
        require(balanceOf[msg.sender] >= _value, "Insufficient funds");
        balanceOf[msg.sender]-= _value;
        balanceOf[_to]+= _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0));
        require(allowance[_from][msg.sender] >= _value, "Unauthorized");
        require(balanceOf[_from] >= _value, "Insufficient funds");
        allowance[_from][msg.sender]-= _value;
        balanceOf[_from]-= _value;
        balanceOf[_to]+= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}