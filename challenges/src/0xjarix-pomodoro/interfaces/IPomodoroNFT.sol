// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPomodoroNFT {
    // ERC721 Standard Interface
    function initialize(address _pomodoro) external;
    function balanceOf(address owner) external view returns (uint256);
    function ownerOf(uint256 tokenId) external view returns (address);
    function transferFrom(address from, address to, uint256 tokenId) external;

    // Additional functions for minting and managing the contract
    function mint(address to) external payable;
}
