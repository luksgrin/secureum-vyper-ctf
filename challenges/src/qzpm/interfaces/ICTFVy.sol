pragma solidity ^0.8.10;

interface ICTFVy {
    function token() external view returns (address);
    function deposit(uint256 assets, address to) external;
    function withdraw(uint256 assets, address to) external;
    function balances(address user) external view returns (uint256);
    function convertToAssets(uint256 shares) external view returns (uint256 assets);
    function total_assets() external view returns (uint256);
    function total_shares() external view returns (uint256);
    function isSolved() external view returns (bool);
}
