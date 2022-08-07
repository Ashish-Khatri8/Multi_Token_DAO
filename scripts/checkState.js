const { ethers } = require("hardhat");
const { DAO_ADDRESS, PROPOSAL_ID } = require("./addresses.js");

async function main() {
    const [owner] = await ethers.getSigners();

    // Get the MultiTokenDAO contract and attach deployed address
    const MultiTokenDAO= await ethers.getContractFactory("MultiTokenDAO");
    const multiTokenDAO = await MultiTokenDAO.attach(DAO_ADDRESS);

    // Prints the current state for given proposal id.
    console.log("Proposal current state: ", await multiTokenDAO.state(PROPOSAL_ID));
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })
