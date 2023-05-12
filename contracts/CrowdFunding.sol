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
        uint256[] donations;
          
    }

    mapping (uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function createCampaign( address _owner, string memory _title,
    string memory _description, uint256 _target, uint256 _deadline, string memory _image ) public returns (uint256) {

        Campaign storage campaign = campaigns[numberOfCampaigns];

        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future ");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.deadline = _deadline;
        campaign.description = _description;
        campaign.image = _image;
        campaign.target = _target;
        campaign.amountCollected = 0;

        numberOfCampaigns ++;
    }

    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donors.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    function getDonatorsCampaign(uint256 _id) view public returns (address[] memory, uint256[] memory) {
        return (campaigns[_id].donors, campaigns[_id].donations);
    }

    function getCampaign() public view returns(Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns); // new variable allCampaigns is created of type Campaign[]

        for(uint i=0; i< numberOfCampaigns; i++){
            Campaign storage item = campaigns[i];
            allCampaigns[i] = item;
        }
        return allCampaigns;
    }
}