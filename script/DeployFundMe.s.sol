//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
import {Script} from "forge-std/Script.sol";
import {fundme} from "../src/FundMe.sol";
import {HelpConfig} from "./HelpConfig.s.sol";

contract DeployFundME is Script {
    function run() external returns (fundme) {
        HelpConfig helpConfig = new HelpConfig();
        address feeder = helpConfig.activeConfig();
        vm.startBroadcast();
        fundme FundMe = new fundme(feeder);
        vm.stopBroadcast();
        return FundMe;
    }
}
