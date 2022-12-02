// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UncappedLazySupplyToken is ERC20, Ownable {
    constructor() ERC20("UncappedLazySupplyToken", "ULST") {}

    function mint(address receiver, uint256 amount) onlyOwner public {
        _mint(receiver, amount);
    }
}