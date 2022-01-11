// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./@dropstar/royalties/impl/DropStarERC1155withRoyaltyImpl.sol";
import "./@dropstar/royalties/impl/MultiURIERC1155.sol";

contract DropStarERC1155 is DropStarERC1155withRoyaltyImpl, MultiURIERC1155 {

    using SafeMath for uint256;

    constructor() ERC1155("https://ipfs.io/ipfs/QmceUTvLxgX34pLKgBCFJUiqABTVFoC6Btef68ke2i4hus/{id}"){
        bytes memory data = "\x00";  // you can extend this
        _mint(msg.sender, 0, 10, data);
    }

    function mint(address to,uint256 tokenId,uint256 amount, string memory newuri, bytes memory data) public onlyOwner{
        _mint(to, tokenId, amount, data);
        _setURI(tokenId, newuri);
    }

    function setURI(uint256 tokenId, string memory newuri) public onlyOwner{
        URIs[tokenId] = newuri;
    }

    function burn(address from, uint256 tokenId, uint256 amount) public {
        require(balanceOf(msg.sender, tokenId) >= amount);
        _burn(from, tokenId, amount);
    }
}