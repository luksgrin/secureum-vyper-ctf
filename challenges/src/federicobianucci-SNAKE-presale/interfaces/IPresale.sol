// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IPresale {
    function owner() external view returns (address);

    function presaleEnd() external view returns (uint256);

    function buy() external payable;

    function buyOnBehalfWithPermit(
        address user,
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint256 referralCode,
        address referral
    ) external;

    function withdraw() external;

    function isSolved() external view returns (bool);
}
