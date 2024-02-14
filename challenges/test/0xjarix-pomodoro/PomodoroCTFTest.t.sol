// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {PomodoroCTFDeployer} from "script/0xjarix-pomodoro/PomodoroCTFDeployer.s.sol";
import {IPomodoro} from "src/0xjarix-pomodoro/interfaces/IPomodoro.sol";
import {IPomodoroNFT} from "src/0xjarix-pomodoro/interfaces/IPomodoroNFT.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/



contract PomodoroeCTFTest is Test, PomodoroCTFDeployer {
    IPomodoro public pomodoro;
    IPomodoroNFT public pomodoroNFT;

    /// @notice Deploy the ExampleCTF and the solution contract
    function setUp() public override(PomodoroCTFDeployer) {

        PomodoroCTFDeployer.setUp();

        (address _pomodoroNFT, address _pomodoro) = deployPomodoroCTF();

        pomodoro = IPomodoro(_pomodoro);
        pomodoroNFT = IPomodoroNFT(_pomodoroNFT);

        vm.deal(address(pomodoro), 1000000 ether);

    }

    /// @notice Test that the ExampleCTF is unsolved if we don't do anything
    function test_pomodoroUnsolved() external {
        assertFalse(pomodoro.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved if we call the solve function
    function test_pomodoroSolved() external {
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/

        assertTrue(pomodoro.isSolved());
    }
}
