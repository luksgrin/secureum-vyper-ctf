pragma solidity ^0.8.10;

interface IVaulty {
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event Transfer(address indexed owner, address indexed to, uint256 amount);

    function allowance(address arg0, address arg1) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function assignRewards() external payable;
    function balanceOf(address arg0) external view returns (uint256);
    function decimals() external view returns (uint8);
    function deposit() external payable returns (uint256);
    function flashLoan(address receiver, uint256 amount) external;
    function owner() external view returns (address);
    function rewarders(address arg0) external view returns (bool);
    function setRewarder(address account, bool enabled) external;
    function totalAssets() external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address owner, address to, uint256 amount) external returns (bool);
    function withdraw(uint256 shares) external returns (uint256);
    function isSolved() external view returns (bool);
}

