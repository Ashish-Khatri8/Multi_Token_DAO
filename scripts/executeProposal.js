const { ethers } = require("hardhat");
const { DAO_ADDRESS, TREASURY_ADDRESS, PROPOSAL_ID } = require("./addresses.js");

async function main() {
    const [owner] = await ethers.getSigners();

    // Get the MultiTokenDAO contract and attach deployed address
    const MultiTokenDAO = await ethers.getContractFactory("MultiTokenDAO");
    const multiTokenDAO = await MultiTokenDAO.attach(DAO_ADDRESS);

    // Get the Treasury contract and attach deployed address
    const Treasury = await ethers.getContractFactory("Treasury");
    const treasury = await Treasury.attach(TREASURY_ADDRESS);

    // Check proposal state before executing.
    // 5-> Queued for execution, 6-> Expired
    console.log("Proposal state before executing : ", await multiTokenDAO.state(PROPOSAL_ID));

    // Now execute the proposal.
    const executeTxn = await multiTokenDAO.execute(
        [TREASURY_ADDRESS],
        [0],
        [await treasury.interface.encodeFunctionData("sendEther", [owner.address, ethers.utils.parseUnits("1", 18)])],
        ethers.utils.keccak256(ethers.utils.toUtf8Bytes("Sending 1 ether to owner address!"))
    );
    await executeTxn.wait();
    
    // After successful execution, proposal state would be 7.
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
