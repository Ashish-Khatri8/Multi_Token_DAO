const { ethers } = require("hardhat");
const { DAO_ADDRESS, TREASURY_ADDRESS } = require("./addresses.js");

async function main() {
    const [owner] = await ethers.getSigners();

    // Get the MultiTokenDAO contract and attach deployed address.
    const MultiTokenDAO = await ethers.getContractFactory("MultiTokenDAO");
    const multiTokenDAO = await MultiTokenDAO.attach(DAO_ADDRESS);

    // Get the Treasury contract and attach deployed address.
    const Treasury = await ethers.getContractFactory("Treasury");
    const treasury = await Treasury.attach(TREASURY_ADDRESS);
    
    // Create a proposal to send 1 ether from the treasury to an address.
    const proposalTxn = await multiTokenDAO.propose(
        [TREASURY_ADDRESS],
        [0],
        [await treasury.interface.encodeFunctionData("sendEther", [owner.address, ethers.utils.parseUnits("1", 18)])],
        "Sending 1 ether to owner address!"
    );
    const txn = await proposalTxn.wait();

    // Get the proposalId from the events emitted.
    const proposalId = txn.events[0].args.proposalId;
    console.log("/n -> Created a proposal to send 1 ether to owner with id: ", proposalId);

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
