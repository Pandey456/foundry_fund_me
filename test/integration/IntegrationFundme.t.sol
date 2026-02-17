//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
import {Test, console} from "forge-std/Test.sol";
import {fundme} from "../../src/FundMe.sol";
import {PriceConverter} from "../../src/FundMe/PriceConverter.sol";
import {HelpConfig} from "../../script/HelpConfig.s.sol";
import {DeployFundME} from "../../script/DeployFundMe.s.sol";
import {fund, withdraw} from "../../script/integration.s.sol";

contract FundMeTest is Test {
    fundme fundME;
    HelpConfig helpConfig;
    address feeder;
    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundME deploy = new DeployFundME();
        fundME = deploy.run();
        console.log("fund me addess is %s", address(fundME));
        // vm.deal(USER, STARTING_BALANCE);
    }

    function testfundfundme() public {
        fund funddme = new fund();
        vm.deal(address(funddme), 10 ether);
        funddme.fundFundme(address(fundME));
        address funder = fundME.getFundersArray(0);
        assertEq(funder, address(funddme));
        vm.stopPrank();
    }
}
