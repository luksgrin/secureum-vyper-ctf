// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SuccessionCTFDeployer} from "script/neumoxx-succession/SuccessionCTFDeployer.s.sol";
import {ISuccessionCTFVy} from "src/neumoxx-succession/interfaces/ISuccessionCTFVy.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/



contract SuccessionCTFTest is Test, SuccessionCTFDeployer {
    ISuccessionCTFVy public successionCTF;

    /// @notice Deploy the ExampleCTF and the solution contract
    function setUp() public override(SuccessionCTFDeployer) {

        SuccessionCTFDeployer.setUp();

        successionCTF = ISuccessionCTFVy(deploySuccessionCTF());

        vm.deal(address(successionCTF), 1 ether);


    }

    /// @notice Test that the ExampleCTF is unsolved if we don't do anything
    function test_successionUnsolved() external {
        assertFalse(successionCTF.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved if we call the solve function
    function test_successionSolved() external {
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/

        assertTrue(successionCTF.isSolved());
    }
}
