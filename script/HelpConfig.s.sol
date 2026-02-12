//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/Mock/MockV3Aggregator.sol";

contract HelpConfig is Script {
    uint8 public constant DECIMAL = 8;
    uint256 public constant INITIAL_PRICE = 200e8;
    uint256 public constant SEPOLIA_CHAIN_ID = 11155111;

    struct NetworkConfig {
        address priceFeeder;
    }
    NetworkConfig public activeConfig;

    constructor() {
        if (block.chainid == SEPOLIA_CHAIN_ID) {
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
        MockV3Aggregator anvilPriceFeeder = new MockV3Aggregator(
            DECIMAL,
            INITIAL_PRICE
        );
        vm.startBroadcast();
        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeeder: address(anvilPriceFeeder) // Or a mock address
        });
        return anvilConfig;
    }
}
