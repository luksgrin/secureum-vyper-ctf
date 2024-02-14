// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract ZacByteBrewDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deployZacByteBrewCTF() public returns(address) {
        return vyperDeployer.deployContract(
            "src/zac369-byte-brew/",
            "ZacByteBrew"
        );
    }

    function run() public returns(address) {
        vm.broadcast();
        return deployZacByteBrewCTF();
    }
}
