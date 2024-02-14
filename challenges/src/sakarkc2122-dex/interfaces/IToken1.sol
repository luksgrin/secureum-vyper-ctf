pragma solidity ^0.8.10;

interface IToken1 {
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event Transfer(address indexed owner, address indexed to, uint256 amount);

    function allowance(address arg0, address arg1) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address arg0) external view returns (uint256);
    function mint(address owner, uint256 amount) external;
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address owner, address to, uint256 amount) external returns (bool);
}

