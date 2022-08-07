const { ethers } = require("hardhat");
const { ERC20_TOKEN_ADDRESS } = require("./addresses.js");

async function main() {
    const [owner, addr1, addr2, addr3, addr4, addr5] = await ethers.getSigners();

    // Get the ERC20VotingToken contract and attach deployed address.
    const ERC20VotingToken = await ethers.getContractFactory("ERC20VotingToken");
    const erc20VotingToken = await ERC20VotingToken.attach(ERC20_TOKEN_ADDRESS);

    // Delegate the ERC20 voting tokens from each address to itself..
    await erc20VotingToken.connect(owner).delegate(owner.address);
    await erc20VotingToken.connect(addr1).delegate(addr1.address);
    await erc20VotingToken.connect(addr2).delegate(addr2.address);
    await erc20VotingToken.connect(addr3).delegate(addr3.address);
    await erc20VotingToken.connect(addr4).delegate(addr4.address);
    await erc20VotingToken.connect(addr5).delegate(addr5.address);
    
    console.log("Delegated ERC20 voting tokens!");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
