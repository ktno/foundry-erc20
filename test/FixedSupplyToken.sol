// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FixedSupplyToken.sol";

contract FixedSupplyTokenTest is Test {
    uint256 MAX_UINT256 = type(uint256).max;

    function testMintWithMaxSupply() public {
        // action
        FixedSupplyToken fst = new FixedSupplyToken(MAX_UINT256);

        // assert
        assertEq(fst.totalSupply(), MAX_UINT256, "total supply should be max");
        assertEq(fst.balanceOf(address(this)), MAX_UINT256, "balance should be max");
    }

    function testMintWithZeroSupply() public {
        // action
        FixedSupplyToken fst = new FixedSupplyToken(0);

        // assert
        assertEq(fst.totalSupply(), 0, "total supply should be zero");
        assertEq(fst.balanceOf(address(this)), 0, "balance should be zero");
    }

    function testMintWithOverflowSupply() public {
        // when
        vm.expectRevert(stdError.arithmeticError);

        // action
        FixedSupplyToken fst = new FixedSupplyToken(MAX_UINT256 + 1);

        // assert
        assertEq(fst.totalSupply(), 0, "total supply should be zero");
        assertEq(fst.balanceOf(address(this)), 0, "balance should be zero");
    }
}
