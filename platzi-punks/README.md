https://yarnpkg.com/getting-started/install
https://github.com/github/gitignore/blob/main/Node.gitignore
https://github.com/ernestognw/platzi-punks
https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity


https://hardhat.org/getting-started/ Hardhat is a development environment to compile, deploy, test, and debug your Ethereum software. It helps developers manage and automate the recurring tasks that are inherent to the process of building smart contracts and dApps, as well as easily introducing more functionality around this workflow. This means compiling, running and testing smart contracts at the very core.

Usando yarn:

Install in development envirnorment: yarn add hardhat -D
Install harhat dependencies in development envirnorment: yarn add  @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers -D
Create base project: npx hardhat
Throw example script npx hardhat run scripts/sample-script.js
Deploy in a red: npx hardhat run scripts/sample-script.js --network rinkeby
Install dotenv: yarn add dotenv -D


# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
