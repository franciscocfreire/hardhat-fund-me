// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed) public view returns (uint256) {
        // to interact to contract outside ours project
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

        // Dont need fill all fields, just leave comma for field are unsed
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH in terms in USD
        // 3000.00000000
        return uint256(price * 1e10); // 1**10 == 10000000000
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );

        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ehtAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ehtAmountInUsd;
    }
}