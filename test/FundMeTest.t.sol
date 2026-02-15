//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
import {Test, console} from "forge-std/Test.sol";
import {fundme} from "../src/FundMe.sol";
import {PriceConverter} from "../src/FundMe/PriceConverter.sol";
import {HelpConfig} from "../script/HelpConfig.s.sol";

contract FundMeTest is Test {
    fundme FundME;
    HelpConfig helpConfig;
    address feeder;
    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        helpConfig = new HelpConfig();
        feeder = helpConfig.activeConfig();
        FundME = new fundme(feeder);
    }

    function testIsHavingMinUsd() public view {
        assertEq(FundME.MIN_USD(), 100e18);
    }

    function testWhoisTheOwner() public view {
        assertEq(FundME.i_owner(), address(this));
        /**  we did not write 'assertEq(FundME.i_owner(),msg.sender)' bz here we are asking -->
         *  testContract to deploy -->our contract, so the deployer ( that is test contract became
         * the owner , so we are matching that with this contracts address)
         */
    }

    function testWithdrawCanBeOwnerOnly() public view {
        console.log(FundME.getAMT());
        assertEq(FundME.getAMT(), 2037);
        /** Since get AMT is getting price from sepolia network and
         * we are running on local test network
         * to run this we need to add flag
         * 1. -vvv ---> this will rpint hte console.log.
         * 2.--fork-url <alchemy-sepolia-RPC-URL>
         * 3. so final call will look like
         * forge test -vvv --fork-url https://eth-sepolia.g.alchemy......._XYZ
         *
         */
    }

    function testFunRevertWithoutMinCOntribution() public {
        vm.expectRevert(); //this says the nest line must revert and if the next line reverts then only the test is a pass
        FundME.fund();
    }

    function testFundsUpdateFundedData() public {
        vm.prank(USER); // means ---> the next TX will be done my address(USER)
        vm.deal(USER, STARTING_BALANCE); // means ---> it allocates 10eth ( STARTING_BALANCE) to USER
        FundME.fund{value: STARTING_BALANCE}();
        uint val = FundME.getEthInvestedAMount(USER);
        assertEq(val, STARTING_BALANCE);
    }

    function testAddsFunderTOArrayOfFunders() public {
        vm.prank(USER);
        vm.deal(USER, STARTING_BALANCE);
        FundME.fund{value: STARTING_BALANCE}();
        address funder = FundME.getFundersArray(0);
        assertEq(funder, USER);
    }
}
