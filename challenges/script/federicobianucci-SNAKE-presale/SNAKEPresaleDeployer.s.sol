// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract SNAKEPresaleDeployer is Script {
    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deploySNAKEPresaleCTF() public returns (address) {
        return vyperDeployer.deployContract(
            "src/federicobianucci-SNAKE-presale/",
            "Presale",
            abi.encode(block.timestamp + 1 weeks)
        );
    }

    function run() public returns (address) {
        vm.broadcast();
        return deploySNAKEPresaleCTF();
    }
}
