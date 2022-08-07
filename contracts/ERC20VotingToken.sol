// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";


/// @title ERC20VotingToken
/// @author Ashish Khatri
contract ERC20VotingToken is ERC20, ERC20Votes, Ownable {

    /// @dev Calls parent contract's constructors with required arguments.
    constructor() ERC20("ERC20VotingToken", "ERC20VT") ERC20Permit("ERC20VotingToken") {}

    
    /// @dev Overrides decimals() function so that token has 0 decimals.
    function decimals() public pure override returns(uint8) {
        return 0;
    }


    /**
     * @notice Function to mint tokens to an address by the owner.
     * @dev Mints given amount of tokens to the specified address. Can only be called by the owner.
     * @param _to Address to mint tokens to.
     * @param _amount Amount of tokens to mint to the address.
     */
    function mint(address _to, uint256 _amount) external onlyOwner{
        _mint(_to, _amount);
    }

    /**
     * @notice Function to burn tokens.
     * @dev Burns given amount of tokens, if msg.sender's balance is greater than or equal to given amount.
     * @param _amount Amount of tokens to burn.
     */
    function burn(uint256 _amount) external {
        _burn(msg.sender, _amount);
    }

    /* 
        All the functions below are required to be override as they are 
        present in two base contracts.
    */ 
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._mint(to, amount);
    }

    function _burn(
        address account,
        uint256 amount
    ) internal override(ERC20, ERC20Votes) {
        super._burn(account, amount);
    }
    
}
