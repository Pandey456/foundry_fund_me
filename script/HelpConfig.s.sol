//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";

contract HelpConfig {
    struct NetworkConfig {
        address priceFeeder;
    }

    function getSepoliaPrice() public pure returns (NetworkConfig memory) {
        NetworkConfig memory networkconfig = NetworkConfig({
            priceFeeder: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return networkconfig;
    }

    function getAnvilPrice() public pure {}
}
