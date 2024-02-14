pragma solidity ^0.8.10;

interface IZacByteBrew {
    function isSolved() external view returns (bool);
    function modify(uint256 numChars, uint256 slot) external;
    function getSlot(uint256 slot) external view returns (uint256);
}