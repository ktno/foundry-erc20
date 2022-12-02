// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CappedModularSupplyToken is ERC20Capped, Ownable {
    constructor(uint256 cap) ERC20("CappedModularSupplyToken", "CMST") ERC20Capped(cap){}

    function mint(address receiver, uint256 amount) onlyOwner public {
        _mint(receiver, amount);
    }
}