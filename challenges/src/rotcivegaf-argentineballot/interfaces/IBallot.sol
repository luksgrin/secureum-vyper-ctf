pragma solidity ^0.8.10;

import {ILaw} from "./ILaw.sol";

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, uint256) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

interface IOwnable {
    function owner() external view returns (address);
}

interface IBallot is IOwnable, IERC20 {
    struct Election {
        uint256 start;
        ILaw[] laws;
        uint256[] votes;
    }

    function initialize(ILaw[] memory laws) external;
    function lockETH() external view returns (uint256);
    function elections(uint256) external view returns (Election memory);
    function lockVotes(address, uint256) external view returns (uint256);
    function voted(address, uint256) external view returns (bool);
    function electiveLaw() external view returns (ILaw);
    function mintVotes(address _to) external payable;
    function newElection(ILaw[] memory laws) external;
    function proposeLaw(ILaw law) external;
    function vote(uint256 _lawId, uint256 _votes, bytes calldata _identificationMessage) external;
    function getPercentage(uint256 _votes) external view returns(uint256 percentage, bool haveDust);
    function isSolved() external returns(bool);
}