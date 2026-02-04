//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
import {Script} from "forge-std/Script.sol";
import {fundme} from "../src/FundMe.sol";

contract DeployFundME is Script {
    function run() external returns (fundme) {
        vm.startBroadcast();
        fundme FundMe = new fundme();
        vm.stopBroadcast();
        return FundMe;
    }
}
