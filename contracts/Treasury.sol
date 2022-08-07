// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";


/// @title Treasury
/// @author Ashish Khatri
contract Treasury is Ownable, ERC721Holder, ERC1155Holder {

    /// @dev Function to make contract ether receivable.
    receive() external payable {}

    /**
     * @dev Ownable function to send ether to an address.
     * @param _to Address to send ether to.
     * @param _weiAmount Amount in wei to send to the address.
     */
    function sendEther(
        address payable _to,
        uint256 _weiAmount
    ) external onlyOwner {
        require(
            address(this).balance >= _weiAmount, 
            "Treasury: Insufficient ether balance!"
        );
        payable(_to).transfer(_weiAmount);
    }


    /**
     * @dev Ownable function to send ERC20 tokens to an address.
     * @param _tokenAddress Address of ERC20 token to be sent.
     * @param _to Address to send ERC20 tokens to.
     * @param _amount Amount of ERC20 tokens to send to the address.
     */
    function sendERC20Tokens(
        address _tokenAddress,
        address _to,
        uint256 _amount
    ) external onlyOwner {
        require(
            IERC20(_tokenAddress).balanceOf(address(this)) >= _amount,
            "Treasury: Insufficient ERC20 token balance!"
        );

        IERC20(_tokenAddress).transfer(_to, _amount);
    }

    /**
     * @dev Ownable function to send ERC721 token to an address.
     * @param _tokenAddress Address of ERC721 token to be sent.
     * @param _tokenId Id of ERC721 token to send.
     * @param _to Address to send ERC721 token to.
     */
    function sendERC721Token(
        address _tokenAddress,
        uint256 _tokenId,
        address _to
    ) external onlyOwner {
        require(
            IERC721(_tokenAddress).ownerOf(_tokenId) == address(this),
            "Treasury: Not the ERC721 token owner!"
        );
        IERC721(_tokenAddress).safeTransferFrom(address(this), _to, _tokenId, "");
    }

    /**
     * @dev Ownable function to send ERC1155 tokens to an address.
     * @param _tokenAddress Address of ERC1155 tokens to be sent.
     * @param _tokenId Id of ERC1155 tokens to send.
     * @param _to Address to send ERC1155 tokens to.
     * @param _amount Amount of ERC1155 tokens of given id to send to the address.
     */
    function sendERC1155Tokens(
        address _tokenAddress,
        uint256 _tokenId,
        address _to,
        uint256 _amount
    ) external onlyOwner {
        require(
            IERC1155(_tokenAddress).balanceOf(address(this), _tokenId) >= _amount,
            "Treasury: Insufficient ERC1155 token balance!"
        );
        IERC1155(_tokenAddress).safeTransferFrom(address(this), _to, _tokenId, _amount, "");
    }
}
