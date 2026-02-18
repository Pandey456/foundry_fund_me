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
    address internal owner;

    function setUp() external {
        DeployFundME deploy = new DeployFundME();
        fundME = deploy.run();
        owner = fundME.getOwner();

        // vm.deal(USER, STARTING_BALANCE);
    }

    function testfundfundmeAndWithdraw() public {
        //check for fund
        fund funddme = new fund();
        vm.deal(address(funddme), 10 ether);
        funddme.fundFundme(address(fundME));
        address funder = fundME.getFundersArray(0);
        assertEq(funder, address(funddme));
        // vm.stopPrank();
        //address owner = fundME.getOwner();
        withdraw WithDraw = new withdraw();
        address currentOwner = fundME.getOwner();
        console.log("CURRENT OWNER    %s", currentOwner);
        vm.startPrank(currentOwner);
        console.log("running with address is   %s", msg.sender);
        WithDraw.withdrawFundme(address(fundME), currentOwner);
        assertEq(address(fundME).balance, 0);
        vm.stopPrank();
    }
}
