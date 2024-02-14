pragma solidity ^0.8.10;

interface IDex {
    function addLiquidity(address tokenAddress, uint256 amount) external;
    function approve(address spender, uint256 amount) external;
    function balanceOf(address token, address account) external view returns (uint256);
    function isSolved() external returns (bool);
    function setTokens(address _token1, address _token2) external;
    function solve() external;
    function solved() external view returns (bool);
    function swap(address sender, address receiver, uint256 amount) external;
    function token1() external view returns (address);
    function token2() external view returns (address);
}

