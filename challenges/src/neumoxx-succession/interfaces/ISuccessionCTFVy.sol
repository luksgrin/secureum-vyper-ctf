pragma solidity ^0.8.10;

interface ISuccessionCTFVy {
    function siblingShares(address) external view returns (uint256);
    function initCTF() external;
    function restartCTF(address) external;
    function isSolved() external view returns (bool);
    function signMarion(address, uint256) external;
    function signAnna(address, uint256) external;
    function signHenryJunior(address, uint256) external;
    function setKey(uint256, bytes32) external;
}