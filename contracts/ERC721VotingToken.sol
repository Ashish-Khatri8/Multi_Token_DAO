// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/draft-ERC721Votes.sol";


/// @title ERC721VotingToken
/// @author Ashish Khatri
contract ERC721VotingToken is Ownable, ERC721URIStorage, EIP712, ERC721Votes {

    /// @dev Keeps track of last tokenId minted.
    uint256 _tokenId;

    constructor() ERC721("ERC721VotingToken", "ERC721VT") ERC721Votes() EIP712("ERC721VotingToken", "1") {}

    /**
     * @notice Function to mint ERC721 token to an address, with given metadataURI. Callable only by owner.
     * @dev Ownable function to mint token to an address and set its metadataURI to given argument value.
     * @param to Address to which token to be minted.
     * @param metadataURI Metadata link for token minted.
     */
    function mint(address to, string memory metadataURI) public onlyOwner returns(uint256) {
        _tokenId += 1;
        _safeMint(to, _tokenId);
        _setTokenURI(_tokenId, metadataURI);
        return _tokenId;
    }

    /**
     * @notice Function to burn token with given id.
     * @dev Burns the ERC721 token with given id, only if msg.sender is token owner or has approval.
     * @param tokenId Id of the ERC721 token to burn.
     */
    function burn(uint256 tokenId) public {
        _burn(tokenId);
    }

    /* 
        All the functions below are required to be override as they are 
        present in two base contracts.
    */ 

   function _afterTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Votes) {
        super._afterTokenTransfer(from, to, tokenId);
    } 

    function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }


}
