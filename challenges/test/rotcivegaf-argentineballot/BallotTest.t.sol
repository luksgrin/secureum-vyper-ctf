// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {VyperDeployer} from "snekmate-utils/VyperDeployer.sol";

import {ArgentineBallotDeployer} from "script/rotcivegaf-argentineballot/ArgentineBallotDeployer.s.sol";

import {IBallot} from "src/rotcivegaf-argentineballot/interfaces/IBallot.sol";
import {ILaw} from "src/rotcivegaf-argentineballot/interfaces/ILaw.sol";


/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/


contract BallotTest is Test, ArgentineBallotDeployer {

    IBallot public ballot;

    address player = address(420);
    address president = address(240);

    function setUp() public override(ArgentineBallotDeployer) {

        ArgentineBallotDeployer.setUp();

        vm.startPrank(president);

        ILaw[] memory laws = new ILaw[](3);

        laws[0] = ILaw(deployLaw());
        laws[0].initialize();
        laws[1] = ILaw(deployLaw());
        laws[1].initialize();
        laws[2] = ILaw(deployLaw());
        laws[2].initialize();

        ballot = IBallot(deployArgentineBallot());
        ballot.initialize(laws);

        vm.stopPrank();

        vm.deal(player, 1420);
        vm.startPrank(player);
    }

    // @notice Test that the Ballot is unsolved if we don't do anything
    function test_unsolved() external {
        assertFalse(ballot.isSolved());
    }

    function test_solved() external {
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/

        assertTrue(ballot.isSolved());
    }
}
