// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

interface INft {
    function safeMint(address to) external;
}

contract Minter1M is AccessControl {
    INft public nft;

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function setNFT(address address_) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(address_ != address(0), "Invalid address.");
        nft = INft(address_);
    }

    function mintBatch(address[] memory recipients) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(recipients.length > 0, "No addresses provided");
        for (uint256 i = 0; i < recipients.length; i++) {
            nft.safeMint(recipients[i]);
        }
    }
}
