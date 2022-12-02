// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CappedModularSupplyToken.sol";

contract CappedModularSupplyTokenTest is Test {
    uint256 MAX_UINT256 = type(uint256).max;
    uint256 CAP = 1 * 10 ** 18;

    function testMintWithCapSupply() public {
        // when
        CappedModularSupplyToken cmst = new CappedModularSupplyToken(CAP);

        // action
        cmst.mint(address(this), CAP);

        // assert
        assertEq(cmst.totalSupply(), CAP, "total supply should be cap");
        assertEq(cmst.balanceOf(address(this)), CAP, "balance should be cap");
    }

    function testMintWithMaxSupply() public {
        // when
        CappedModularSupplyToken cmst = new CappedModularSupplyToken(MAX_UINT256);

        // action
        cmst.mint(address(this), MAX_UINT256);

        // assert
        assertEq(cmst.totalSupply(), MAX_UINT256, "total supply should be max");
        assertEq(cmst.balanceOf(address(this)), MAX_UINT256, "balance should be max");
    }

    function testMintWithZeroSupply() public {
        // when
        CappedModularSupplyToken cmst = new CappedModularSupplyToken(CAP);

        // action
        cmst.mint(address(this), 0);

        // assert
        assertEq(cmst.totalSupply(), 0, "total supply should be zero");
        assertEq(cmst.balanceOf(address(this)), 0, "balance should be zero");
    }

    function testMintWithOverflowSupply() public {
        // when
        CappedModularSupplyToken cmst = new CappedModularSupplyToken(CAP);

        // action
        vm.expectRevert(stdError.arithmeticError);
        cmst.mint(address(this), MAX_UINT256 + 1);

        // assert
        assertEq(cmst.totalSupply(), 0, "total supply should be zero");
        assertEq(cmst.balanceOf(address(this)), 0, "balance should be zero");
    }

    function testMintAfterTheCapIsReached () public {
        // when
        CappedModularSupplyToken cmst = new CappedModularSupplyToken(CAP);

        // action
        cmst.mint(address(this), CAP);
        vm.expectRevert("ERC20Capped: cap exceeded");
        cmst.mint(address(this), 1);

        // assert
        assertEq(cmst.totalSupply(), CAP, "total supply should be cap");
        assertEq(cmst.balanceOf(address(this)), CAP, "balance should be cap");
    }
}
