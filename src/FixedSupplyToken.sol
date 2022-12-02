// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FixedSupplyToken is ERC20 {
    constructor(uint256 supply) ERC20("FixedSupplyToken", "FST") {
        _mint(msg.sender, supply);
    }
}