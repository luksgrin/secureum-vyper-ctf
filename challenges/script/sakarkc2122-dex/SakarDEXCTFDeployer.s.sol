// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract SakarDEXCTFDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deploySakarDEXCTF() public returns(address dex, address token1, address token2) {
        dex = vyperDeployer.deployContract(
            "src/sakarkc2122-dex/",
            "Dex"
        );
        token1 = vyperDeployer.deployContract(
            "src/sakarkc2122-dex/",
            "Token1"
        );
        token2 = vyperDeployer.deployContract(
            "src/sakarkc2122-dex/",
            "Token2"
        );

    }

    function run() public returns(address, address, address) {
        vm.broadcast();
        return deploySakarDEXCTF();
    }
}
