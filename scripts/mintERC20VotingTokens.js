const { ethers } = require("hardhat");
const { ERC20_TOKEN_ADDRESS } = require("./addresses.js");

async function main() {
    const [owner, addr1, addr2, addr3, addr4, addr5] = await ethers.getSigners();

    // Get the ERC20VotingToken contract and attach deployed address.
    const ERC20VotingToken = await ethers.getContractFactory("ERC20VotingToken");
    const erc20VotingToken = await ERC20VotingToken.attach(ERC20_TOKEN_ADDRESS);

    // Minting 20 tokens to each address.
    const amount = ethers.utils.parseUnits("20", 18);

    // Mint the ERC20 voting tokens to other addresses.
    await erc20VotingToken.mint(owner.address, amount);
    await erc20VotingToken.mint(addr1.address, amount);
    await erc20VotingToken.mint(addr2.address, amount);
    await erc20VotingToken.mint(addr3.address, amount);
    await erc20VotingToken.mint(addr4.address, amount);
    await erc20VotingToken.mint(addr5.address, amount);

    console.log("Minted ERC20 Voting Tokens!");
    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
