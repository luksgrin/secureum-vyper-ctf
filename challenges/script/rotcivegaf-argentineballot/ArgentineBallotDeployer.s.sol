// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract ArgentineBallotDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deployArgentineBallot() public returns(address) {
        return vyperDeployer.deployContract(
            "src/rotcivegaf-argentineballot/",
            "Ballot"
        );
    }

    function deployLaw() public returns(address) {
        return vyperDeployer.deployContract(
            "src/rotcivegaf-argentineballot/",
            "Law"
        );
    }

    function deployProposeLaw() public returns(address) {
        return vyperDeployer.deployContract(
            "src/rotcivegaf-argentineballot/",
            "ProposeLaw"
        );
    }

    function run() public returns(address, address, address) {
        vm.broadcast();
        return (
            deployArgentineBallot(),
            deployLaw(),
            deployProposeLaw()
        );
    }
}
