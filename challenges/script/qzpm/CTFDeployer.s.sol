// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";
import {MockERC20} from "src/qzpm/MockERC20.sol";

contract CTFDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deployCTF() public returns(MockERC20, address) {
        MockERC20 token = new MockERC20();
        address ctf = vyperDeployer.deployContract(
            "src/qzpm/",
            "CTFVy",
            abi.encode(token)
        );

        return (token, ctf);
    }

    function run() public returns(address) {
        vm.broadcast();
        (, address ctf) = deployCTF();
        return ctf;
    }
}
