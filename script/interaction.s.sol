//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Script, console} from "forge-std/Script.sol";
import {fundme} from "../src/FundMe.sol";

contract fund is Script {
    uint256 constant SEND_AMT = 0.1 ether;

    function fundFundme(address latestCA) public {
        vm.startBroadcast();
        fundme(payable(latestCA)).fund{value: SEND_AMT}();
        vm.stopBroadcast();
    }

    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment(
            "fundme",
            block.chainid
        );
        fundFundme(contractAddress);
    }
}

contract withdraw is Script {
    function withdrawFundme(address latestCA) public {
        vm.startBroadcast();
        fundme(payable(latestCA)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment(
            "fundme",
            block.chainid
        );
        withdrawFundme(contractAddress);
    }
}
