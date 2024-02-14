// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract VaultyDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deployVaulty() public returns(address) {
        return vyperDeployer.deployContract(
            "src/romeroadrian-vaulty/",
            "Vaulty"
        );
    }

    function run() public returns(address) {
        vm.broadcast();
        return deployVaulty();
    }
}
