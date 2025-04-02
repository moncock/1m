// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MillionNadsOneCock is ERC721, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 private _nextTokenId;
    string private _img = "https://moncock.github.io/1m/1m.png";
    string private _desc = "From zero to 1M-Moncock witnessed it all. Now it's your turn to hold a piece of the legend.";

    constructor()
        ERC721("Million Nads, One Cock", "MNOC")
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function safeMint(address to) public onlyRole(MINTER_ROLE) returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        return tokenId;
    }

    // metadata
    function setImg(string calldata newImg) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _img = newImg;
    }
    function setDesc(string calldata newDesc) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _desc = newDesc;
    }
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string.concat(
            "data:application/json;utf8,",
            '{"name": "Million Nads, One Cock #', Strings.toString(tokenId),
            '","description":"', _desc,
            '","image":"', _img, '"}'
        );
    }

    // soulbound
    function transferFrom(address, address, uint256) public pure override {
        revert("Soulbound: Transfers not allowed");
    }
    function safeTransferFrom(address, address, uint256, bytes memory) public pure override {
        revert("Soulbound: Transfers not allowed");
    }
    function approve(address, uint256) public pure override {
        revert("Soulbound: Approvals not allowed");
    }
    function setApprovalForAll(address, bool) public pure override {
        revert("Soulbound: Approvals not allowed");
    }

    // The following functions are overrides required by Solidity.
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
