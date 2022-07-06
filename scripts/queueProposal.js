const { ethers } = require("hardhat");
const { DAO_ADDRESS, TREASURY_ADDRESS, PROPOSAL_ID } = require("./addresses.js");

async function main() {
    const [owner] = await ethers.getSigners();

    // Get the MultiTokenDAO contract and attach deployed address
    const MultiTokenDAO = await ethers.getContractFactory("MultiTokenDAO");
    const multiTokenDAO = await MultiTokenDAO.attach(DAO_ADDRESS);

    const Treasury = await ethers.getContractFactory("Treasury");
    const treasury = await Treasury.attach(TREASURY_ADDRESS);

    // Check proposal state before queueing.
    // 1-> voting active, 2-> Canceled, 3-> Defeated, 4-> Succeeded
    console.log("Proposal state before queueing: ", await multiTokenDAO.state(PROPOSAL_ID));

    // Now, queue the proposal.
    const queueTxn = await multiTokenDAO.queue(
        [TREASURY_ADDRESS],
        [0],
        [await treasury.interface.encodeFunctionData("sendEther", [owner.address, ethers.utils.parseUnits("1", 18)])],
        ethers.utils.keccak256(ethers.utils.toUtf8Bytes("Sending 1 ether to owner address!"))
    );
    await queueTxn.wait();
    console.log("Queued the proposal!");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
