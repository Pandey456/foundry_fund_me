// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import {PriceConverter} from "./FundMe/PriceConverter.sol";
error notOwner();

contract fundme {
    using PriceConverter for uint256;
    address[] public funders;
    uint public constant MIN_USD = 100e18;
    mapping(address => uint256) public funderToAmountFunded;
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    //extra function remove it later
    function getAMT() public view returns (uint256) {
        return PriceConverter.getConversionRate(1);
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MIN_USD, "not enough ETH");
        funders.push(msg.sender);
        funderToAmountFunded[msg.sender] =
            funderToAmountFunded[msg.sender] +
            msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint index = 0; index < funders.length; index++) {
            address investor = funders[index];
            funderToAmountFunded[investor] = 0;
        }
        (bool status, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(status, "Transfer failed");
    }

    modifier onlyOwner() {
        //require(msg.sender == i_owner,"Only i_owner can withdraw");
        if (msg.sender != i_owner) {
            revert notOwner();
        }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
