pragma solidity ^0.4.21;

contract PublicKeyChallenge {
    address owner = 0x92b28647ae1f3264661f72fb2eb9625a89d88a31;
    bool public isComplete;

    function authenticate(bytes publicKey) public {
        require(address(keccak256(publicKey)) == owner);

        isComplete = true;
    }
}

/*
Information:
https://ethereum.stackexchange.com/questions/3542/how-are-ethereum-addresses-generated
https://kobl.one/blog/create-full-ethereum-keypair-and-address/
https://ethereum.stackexchange.com/questions/13778/get-public-key-of-any-ethereum-account/79174

tool:
https://toolkit.abdk.consulting/ethereum#recover-address,address-checksum,transaction


transacctions from address:
https://ropsten.etherscan.io/address/0x92b28647ae1f3264661f72fb2eb9625a89d88a31


Solution:

First we have to obtained the public key. There are several tools, but I use this form:

Open the transaction in Etherscan.io (https://ropsten.etherscan.io/tx/0xabc467bedd1d17462fcc7942d0af7874d6f8bdefee2b299c9168a216d3ff0edb)
Click on vertical ellipsis in the top-right corner
Click on "Get Row TxnHash" in popup menu
You will see raw transaction in hex, copy it
Open “Recover address” tool from ABDK Toolkit (https://toolkit.abdk.consulting/ethereum#recover-address,address-checksum,transaction)
Select "Transaction" radio button
Paste raw transaction into "Message" field
See the public key in the text bow below

We obtained this result:

Transaction: 0xf87080843b9aca0083015f90946b477781b0e68031109f21887e6b5afeaaeb002b808c5468616e6b732c206d616e2129a0a5522718c0f95dde27f0827f55de836342ceda594d20458523dd71a539d52ad7a05710e64311d481764b5ae8ca691b05d14054782c7d489f3511a7abf2f5078962
Publick key compressed: 0x02613a8d23bd34f7e568ef4eb1f68058e77620e40079e88f705dfb258d7a06a1a0
publick key uncompressed: 0x04613a8d23bd34f7e568ef4eb1f68058e77620e40079e88f705dfb258d7a06a1a0364dbe56cab53faf26137bec044efd0b07eec8703ba4a31c588d9d94c35c8db4

We have to replace the 0x04 for 0x in the public key uncompressed to obtained the result.

0x613a8d23bd34f7e568ef4eb1f68058e77620e40079e88f705dfb258d7a06a1a0364dbe56cab53faf26137bec044efd0b07eec8703ba4a31c588d9d94c35c8db4

To undestand more read the links in the information part


*/