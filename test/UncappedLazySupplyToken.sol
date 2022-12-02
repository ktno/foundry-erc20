// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/UncappedLazySupplyToken.sol";

contract UncappedLazySupplyTokenTest is Test {
    uint256 MAX_UINT256 = type(uint256).max;

    function testMintWithMaxSupply() public {
        // when
        UncappedLazySupplyToken ulst = new UncappedLazySupplyToken();

        // action
        ulst.mint(address(this), MAX_UINT256);

        // assert
        assertEq(ulst.totalSupply(), MAX_UINT256, "total supply should be max");
        assertEq(ulst.balanceOf(address(this)), MAX_UINT256, "balance should be max");
    }

    function testMintWithZeroSupply() public {
        // when
        UncappedLazySupplyToken ulst = new UncappedLazySupplyToken();

        // action
        ulst.mint(address(this), 0);

        // assert
        assertEq(ulst.totalSupply(), 0, "total supply should be zero");
        assertEq(ulst.balanceOf(address(this)), 0, "balance should be zero");
    }

    function testMintWithOverflowSupply() public {
        // when
        UncappedLazySupplyToken ulst = new UncappedLazySupplyToken();

        // action
        vm.expectRevert(stdError.arithmeticError);
        ulst.mint(address(this), MAX_UINT256 + 1);

        // assert
        assertEq(ulst.totalSupply(), 0, "total supply should be zero");
        assertEq(ulst.balanceOf(address(this)), 0, "balance should be zero");
    }

    function testMintAfterTheCapIsReached () public {
        // when
        UncappedLazySupplyToken ulst = new UncappedLazySupplyToken();

        // action
        ulst.mint(address(this), MAX_UINT256);
        vm.expectRevert(stdError.arithmeticError);
        ulst.mint(address(this), 1);

        // assert
        assertEq(ulst.totalSupply(), MAX_UINT256, "total supply should be max");
        assertEq(ulst.balanceOf(address(this)), MAX_UINT256, "balance should be max");
    }
}
