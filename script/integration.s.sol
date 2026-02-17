//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Script, console} from "forge-std/Script.sol";
import {fundme} from "../src/FundMe.sol";

contract fund is Script {
    uint256 constant SEND_AMT = 2 ether;

    function fundFundme(address latestCA) public {
        fundme(payable(latestCA)).fund{value: SEND_AMT}();

        console.log("Funded FundMe with %s", SEND_AMT);
    }

    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment(
            "fundme",
            block.chainid
        );
        vm.startBroadcast();
        fundFundme(contractAddress);
        vm.stopBroadcast();
    }
}

// contract withdraw is Script {
//     function withdrawFundme(address latestCA) public {
//         vm.startBroadcast();
//         fundme(payable(latestCA)).withdraw();
//         vm.stopBroadcast();
//     }

//     function run() external {
//         address contractAddress = DevOpsTools.get_most_recent_deployment(
//             "fundme",
//             block.chainid
//         );
//         withdrawFundme(contractAddress);
//     }
// }
