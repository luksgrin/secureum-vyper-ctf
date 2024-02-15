pragma solidity ^0.8.10;


interface ILaw {
    function initialize() external;
    function president() external view returns (address);
}

interface IProposeLaws is ILaw {
    function newElection(address) external;
}