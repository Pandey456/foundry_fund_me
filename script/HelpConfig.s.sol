//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/Mock/MockV3Aggregator.sol";

contract HelpConfig is Script {
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

    function getAnvilPrice() public returns (NetworkConfig memory) {
        vm.startBroadcast();
        MockV3Aggregator anvilPriceFeeder = new MockV3Aggregator(8, 2000e8);
        vm.startBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeeder: address(anvilPriceFeeder) // Or a mock address
        });
        return anvilConfig;
    }
}
