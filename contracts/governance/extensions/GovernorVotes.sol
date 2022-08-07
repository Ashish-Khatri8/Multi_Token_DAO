// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (governance/extensions/GovernorVotes.sol)

pragma solidity ^0.8.0;

import "../Governor.sol";
import "@openzeppelin/contracts/governance/utils/IVotes.sol";

/**
 * @dev Extension of {Governor} for voting weight extraction from an {ERC20Votes} token, or since v4.5 an {ERC721Votes} token.
 *
 * _Available since v4.3._
 */
abstract contract GovernorVotes is Governor {
    IVotes[] public votingTokens;

    constructor(IVotes[] memory _votingTokens) {
        votingTokens = _votingTokens;
    }

    /**
     * Read the voting weight from the token's built in snapshot mechanism (see {Governor-_getVotes}).
     */
    function _getVotes(
        uint8 tokenAddress,
        address account,
        uint256 blockNumber,
        bytes memory /*params*/
    ) internal view virtual override returns (uint256) {
        return votingTokens[tokenAddress].getPastVotes(account, blockNumber);
    }

    function _getAllVotes(
        address account,
        uint256 blockNumber,
        bytes memory /*params*/
    ) internal view virtual override returns (uint256) {
        uint256 totalVotes;
        for (uint8 i; i<votingTokens.length; i++) {
            totalVotes += votingTokens[i].getPastVotes(account, blockNumber);
        }
        return totalVotes;
    }
}
