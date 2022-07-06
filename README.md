# MultiTokenDAO

- An on-chain DAO with multiple voting tokens.
- Voting tokens can be ERC20 or ERC721.


## Contract: ERC20VotingToken.sol

This contract deploys an **ERC20 token with voting rights**.

- Name: "ERC20VotingToken"
- Symbol: "ERC20VT"
- Decimals: 0

- This token will be used to vote on proposals created in the MultiTokenDAO contract.

- Each token delegated gives 1 voting power.

- The contract owner can call the **mint()** function to mint tokens to an address.
It takes the address and the amount of tokens to mint as arguments.

- Users would need to call **delegate()** function and pass their own address as argument in order to create a snapshot of their voting power, as only holding the tokens does not give an address the equivalent voting power.

---

## Contract: ERC721VotingToken.sol

This contract deploys an **ERC721 token with voting rights**.

- Name: "ERC721VotingToken"
- Symbol: "ERC721VT"

- This token will also be used to vote on proposals created in the MultiTokenDAO contract.

- Each token delegated gives 1 voting power.

- The contract owner can call the **mint()** function to mint tokens to an address.
It takes the target address and the token metadataURI as arguments.

- Users would need to call **delegate()** function and pass their own address as argument in order to create a snapshot of their voting power, as only holding the tokens does not give an address the equivalent voting power.

---

## Contract: Treasury.sol

- This contract will hold ether, ERC20, ERC721, and ERC1155 tokens and will be used to send the same as addresses via executed proposals.

- The members of the MultiTokenDAO can create a proposal where they can specify which function to call with its required arguments.

- If the MultiTokenDAO members pass in favor of the proposal, then the said amount will be sent to the address.

- The TimeLock contract is given the ownership of this contract, so that the only way of moving funds out is by creating a proposal and passing it.

---

## Contract: TimeLock.sol

- This contract is set as the **owner of the Treasury contract**.

- It sets a minimum delay time(number of blocks), that a passed proposal has to wait before getting executed.

- The **MultiTokenDAO contract** is set as the only **PROPOSER**, which means only that contract can suggest this contract to do a transaction through the Treasury contract.

- The **Null Address** is set as the **EXECUTOR**, which gives each and every address the right to execute a passed proposal, given that it has waited out the proposed delay time.

---

## Contract: MultiTokenDAO.sol

- This contract creates the DAO ecosystem in which an user can create a proposal and vote on it using the supported ERC20 and ERC721 voting tokens.

- Users can only vote with one supported token for the same proposalId.

- Users can create a proposal, cancel it, vote on it, queue it and execute it.

- The proposal stages are as follows:

```script
    Number          Stage

    0               Pending
    1               Active
    2               Canceled
    3               Defeated
    4               Succeeded
    5               Queued
    6               Expired
    7               Executed
```

---

- An user can interact with the **propose()** function to create a new proposal, which returns the proposal id of the newly created proposal.

- Users can interact with the **castVote()** function to cast their vote on a proposal. It takes 3 arguments=> tokenIndex, proposal id and support.

- tokenIndex refers to index of token that user wants to vote with, in the votingTokens array. (See contracts/governance/extensions/GovernorVotes.sol)

- Here 0 => ERC20 voting token and 1 => ERC721 voting token.

- User has 3 values for support when voting:

```script
    Choice      Meaning

    0           Against the proposal
    1           For/ In favor of the proposal
    2           Abstain
```

- If the proposal passes, then any user can interact with the **queue()** function to queue the proposal for execution.

- After that, when the delay period has passed, any user can interact with the **execute()** function which will execute the proposal and the funds will be sent to the address.

---
---

### Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case.

```shell
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
