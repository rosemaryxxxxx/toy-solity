// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

//1 创建一个收款函数
//2 记录投资人并查看
//3 在锁定期内，达到目标值，生产商可以提款
//4 在锁定期内，未达到目标值，投资人在锁定期有以后可以退款

contract FundMe {
    mapping (address => uint256) public fundersToAmount;

    uint256 MINIMUN_VALUE = 100 * 10 ** 18; //usd

    AggregatorV3Interface internal dataFeed;

    constructor() {
        //sepolia test
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function fund() external payable {
        require(convertEthToUsd(msg.value) >= MINIMUN_VALUE, "Send more ETH" );
        fundersToAmount[msg.sender] += msg.value;
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function convertEthToUsd(uint256 ethAmount) internal view returns(uint256) { 
        uint256 ethPrice =uint256( getChainlinkDataFeedLatestAnswer() );
        return ethAmount * ethPrice/(10**8);
    }
}
