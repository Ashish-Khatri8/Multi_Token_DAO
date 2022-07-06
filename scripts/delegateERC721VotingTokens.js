const { ethers } = require("hardhat");
const { ERC721_TOKEN_ADDRESS } = require("./addresses.js");

async function main() {
    const [owner, addr1, addr2, addr3, addr4, addr5] = await ethers.getSigners();

    // Get the ERC721VotingToken contract and attach deployed address.
    const ERC721VotingToken = await ethers.getContractFactory("ERC721VotingToken");
    const erc721VotingToken = await ERC721VotingToken.attach(ERC721_TOKEN_ADDRESS);

    // Delegate the ERC721 voting tokens from each address to itself..
    await erc721VotingToken.connect(owner).delegate(owner.address);
    await erc721VotingToken.connect(addr1).delegate(addr1.address);
    await erc721VotingToken.connect(addr2).delegate(addr2.address);
    await erc721VotingToken.connect(addr3).delegate(addr3.address);
    await erc721VotingToken.connect(addr4).delegate(addr4.address);
    await erc721VotingToken.connect(addr5).delegate(addr5.address);
    
    console.log("Delegated ERC721 voting tokens!");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
