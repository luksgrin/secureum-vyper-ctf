pragma solidity ^0.8.10;

interface ICrowdFund {
    event Approval(address owner, address spender, uint256 value, address executor);
    event Buy(address buyer, address receiver, uint256 amount);
    event Sell(address seller, address receiver, uint256 amount);
    event Transfer(address sender, address receiver, uint256 value, address executor);

    function allowance(address _holder, address _spender) external view returns (uint256);
    function approve(address _holder, address _spender, uint256 _value) external returns (bool);
    function approveMax(address _holder, address _spender) external returns (bool);
    function balanceOf(address _holder) external view returns (uint256);
    function burn(address _from, uint256 _value) external returns (bool);
    function buy(address receiver) external payable;
    function decimals() external view returns (uint256);
    function isSolved() external view returns (bool);
    function mint(address _to, uint256 _value) external returns (bool);
    function name() external view returns (string memory);
    function owner() external view returns (address);
    function sell(address receiver, uint256 amount) external;
    function spendAllowance(address _holder, address _spender, uint256 _value) external returns (bool);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function transfer(address _to, uint256 _value) external returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
    function transferOwnership(address _newOwner) external;
}

