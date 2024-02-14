// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract VexillologyDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deployVexillology() public returns(address) {
        return vyperDeployer.deployContract(
            "src/eloi010-vexillology/",
            "VexillologyVy",
            abi.encode("Ethereum") // countryName
        );
    }

    function run() public returns(address) {
        vm.broadcast();
        return deployVexillology();
    }
}
