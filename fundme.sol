// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract Fundme
{
    using SafeMathChainlink for uint256;
    mapping(address => uint256) public addressToAmountFund;
    address public owner;
    address[] public funder;
    constructor() public
    {
        owner = msg.sender;
    }
    function fund() public payable
    {
        uint256 min_USD = 50*10**18;
        require(getConversionRate(msg.value) >= min_USD, "You need to spend atleast 50 USD");
        addressToAmountFund[msg.sender] += msg.value;
    }

    function getPrice() public view returns(uint256)
    {
        AggregatorV3Interface pF = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 answer,,,) = pF.latestRoundData();
        return uint256(answer);
    }

    function getConversionRate(uint256 ethAmt) public view returns(uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmtUSD = (ethPrice * ethAmt);
        return ethAmtUSD;
    }

    modifier onlyOwner
    {
        require(msg.sender == owner);
        _;
    }

    function withdraw() public onlyOwner payable
    {
        msg.sender.transfer(address(this).balance);
        for(uint256 funderIndex = 0; funderIndex <= funder.length; funderIndex++)
        {
            address payer = funder[funderIndex];
            addressToAmountFund[payer] = 0;
        }
        funder = new address[](0);
    }
}
