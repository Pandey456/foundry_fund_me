//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
import {Test, console} from "forge-std/Test.sol";
import {fundme} from "../src/FundMe.sol";

contract FundMeTest is Test {
    fundme FundME;

    function setUp() external {
        FundME = new fundme();
    }

    function testIsHavingMinUsd() public view {
        assertEq(FundME.MIN_USD(), 100e18);
    }
}
