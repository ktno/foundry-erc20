// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/FixedSupplyToken.sol";
import "../src/UncappedLazySupplyToken.sol";
import "../src/CappedModularSupplyToken.sol";

contract Deployment is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        FixedSupplyToken fst = new FixedSupplyToken(type(uint256).max);
        UncappedLazySupplyToken ulst = new UncappedLazySupplyToken();
        CappedModularSupplyToken cmst = new CappedModularSupplyToken(type(uint128).max);
        vm.stopBroadcast();
    }
}