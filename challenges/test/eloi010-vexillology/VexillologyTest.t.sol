// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {VexillologyDeployer} from "script/eloi010-vexillology/VexillologyDeployer.s.sol";
import {IVexillologyVy} from "src/eloi010-vexillology/interfaces/IVexillologyVy.sol";

/// VexillologyTest to showcase the solution to the Vexillology challenge
contract VexillologyTest is Test, VexillologyDeployer {
    IVexillologyVy public vyperVexillology;

    /// @notice Deploy the Vexillology contract
    function setUp() public override(VexillologyDeployer) {
        VexillologyDeployer.setUp();
        vyperVexillology = IVexillologyVy(deployVexillology());
    }

    /// @notice Test that the Vexilollogy is unsolved if we don't do anything
    function test_vexillologyUnsolved() external {
        assertFalse(vyperVexillology.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved
    function test_vexillologySolved() external {
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/

        assertTrue(vyperVexillology.isSolved());
    }
}
