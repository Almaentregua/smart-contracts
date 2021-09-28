const config = require('./configs');

var Web3 = require("web3");
var web3 = new Web3(config.nodoUrl);
web3.eth.getBalance(config.address, (err, _balance) => {
	balance = _balance,
	console.log(web3.utils.fromWei(balance, 'ether'))
})