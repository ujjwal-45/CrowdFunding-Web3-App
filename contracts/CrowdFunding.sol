// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 amountCollected;
        uint256 target;
        uint256 deadline;
        string image;//image url -> string
        address[] donors;
        address[] donations;
          
    }
}