// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract CrowdFundDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deployCrowdFund() public returns(address) {
        return vyperDeployer.deployContract(
            "src/m4ttm-crowdfund/",
            "Crowdfund"
        );
    }

    function run() public returns(address) {
        vm.broadcast();
        return deployCrowdFund();
    }
}
