// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPomodoro {
    // Initializes the contract with the NFT address
    function initialize() external;

    function setPomodoroNFTAddress(address _nftAddress) external;
    // Starts a work session for the NFT owner
    function startWorkSession(uint256 _tokenId) external;

    // Pauses the current work session
    function pauseWorkSession(uint256 _tokenId) external;

    // Unpauses the current work session
    function unpauseWorkSession(uint256 _tokenId) external;

    // Claims the reward for the work session
    function claimReward(uint256 _tokenId) external;

    function isSolved() external view returns (bool);
}
