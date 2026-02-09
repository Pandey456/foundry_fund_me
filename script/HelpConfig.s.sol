//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";

contract HelpConfig {
    struct NetworkConfig {
        address priceFeeder;
    }
    NetworkConfig public activeConfig;

    constructor() {
        if (block.chainid == 11155111) {
            activeConfig = getSepoliaPrice();
        } else {
            activeConfig = getAnvilPrice();
        }
    }

    function getSepoliaPrice() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaconfig = NetworkConfig({
            priceFeeder: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaconfig;
    }

    function getAnvilPrice() public pure returns (NetworkConfig memory) {
        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeeder: 0xAaAaa1769357215dE4fac081bF1F309ADc325306 // Or a mock address
        });
        return anvilConfig;
    }
}
