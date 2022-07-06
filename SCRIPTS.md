## How to use the provided scripts to check the working of the MultiTokenDAO:

---

### Requirement:

First, create a **.env** file in the project root directory and paste the following details:-

```script
MNEMONICS="your metamask seedphrase"
RINKEBY_HTTP_INFURA="rinkeby rpc url, any would work"
ROPSTEN_HTTP_INFURA="rinkeby rpc url, any would work"
```

Note: Don't paste private key in MNEMONICS as scripts use at least 6 addresses for voting purposes. Also, make sure that your first 6 accounts in metamask have sufficient ethers for doing transactions.

---

### How to run scripts in terminal:

> npx hardhat run scripts/scriptName.js --network rinkeby/ropsten

---

### Workflow:

1. Run the **deploy.js** script.
  -  This script deploys all the contracts and prints their addresses.
  - Copy these addresses and paste them into **addresses.js** respectively.
  - Also, this script transfers the **Treasury** ownership to **Timelock**.
  - It also grants the **MultiTokenDAO** contract the proposer role for Timelock contract.
  - It sends 1 ether from your first account to the Treasury contract too.

---

2. Run the **mintERC20VotingTokens.js** script.
  - This script mints 20 ERC20VT tokens to your first 6 addresses each.

---

3. Run the **mintERC721VotingTokens.js** script.
  - This script mints 1 ERC721VT token to your first 6 addresses each.

---

4. Run the **delegateERC20VotingTokens.js** script.
  - This script delegates voting powers of ERC20VT token of your first 6 addresses to themselves.

---

4. Run the **delegateERC721VotingTokens.js** script.
  - This script delegates voting powers of ERC721VT token of your first 6 addresses to themselves.

---

5. Run the **createProposal.js** script.
  - This script creates a proposal to send 1 ether from the Treasury to your first account.
  - It prints the **proposalId** on its successful creation.
  - Copy and paste this proposalId into the **addresses.js** file.

---

6. Run the **voteOnProposal.js** script.
  - This script votes on the proposal created above with your accounts such that the proposal passes.
  - After this, check on etherscan the blockNumber in which your proposal was created, and do the next script only after **blocks for voting period** specified in deploy.js have passed.

--- 

7. Run the **queueProposal.js** script.
  - This script queues the proposal created above for execution,
  after its voting period has passed and the proposal was successful.

---

8. Finally, run the **executeProposal.js** script.
  - This script executes the proposal created above.
  - You should receive the 1 ether from Treasury, once it is successfully executed.

---
