const { ethers } = require("hardhat");
const { ERC721_TOKEN_ADDRESS } = require("./addresses.js");

async function main() {
    const [owner, addr1, addr2, addr3, addr4, addr5] = await ethers.getSigners();

    // Get the ERC721VotingToken contract and attach deployed address.
    const ERC721VotingToken = await ethers.getContractFactory("ERC721VotingToken");
    const erc721VotingToken = await ERC721VotingToken.attach(ERC721_TOKEN_ADDRESS);

    // Mint the ERC721 voting tokens to other addresses.
    await erc721VotingToken.mint(owner.address, "");
    await erc721VotingToken.mint(addr1.address, "");
    await erc721VotingToken.mint(addr2.address, "");
    await erc721VotingToken.mint(addr3.address, "");
    await erc721VotingToken.mint(addr4.address, "");
    await erc721VotingToken.mint(addr5.address, "");

    
    console.log("Minted ERC721 voting tokens!");
    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
