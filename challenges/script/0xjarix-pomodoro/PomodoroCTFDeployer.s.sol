// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

contract PomodoroCTFDeployer is Script {

    VyperDeployer vyperDeployer;

    function setUp() public virtual {
        vyperDeployer = new VyperDeployer();
    }

    function deployPomodoroCTF() public returns(address pomodoroNFT, address pomodoro) {
        pomodoro = vyperDeployer.deployContract(
            "src/0xjarix-pomodoro/",
            "Pomodoro"
        );
        pomodoroNFT = vyperDeployer.deployContract(
            "src/0xjarix-pomodoro/",
            "PomodoroNFT",
            abi.encode(pomodoro)
        );
    }

    function run() public returns(address, address) {
        vm.broadcast();
        return deployPomodoroCTF();
    }
}
