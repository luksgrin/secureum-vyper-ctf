// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {VaultyDeployer} from "script/romeroadrian-vaulty/VaultyDeployer.s.sol";
import {IVaulty} from "src/romeroadrian-vaulty/interfaces/IVaulty.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/



contract VaultyTest is Test, VaultyDeployer {
    IVaulty public vaulty;

    address player = address(420);

    address vaultyowner = makeAddr("owner");
    address alice = makeAddr("Alice");

    /// @notice Deploy the ExampleCTF and the solution contract
    function setUp() public override(VaultyDeployer) {

        VaultyDeployer.setUp();

        vm.deal(alice, 15 ether);
        vm.deal(player, 20 ether);

        vm.startPrank(vaultyowner);
        vaulty = IVaulty(deployVaulty());
        vm.stopPrank();
    }

    /// @notice Test that the ExampleCTF is unsolved if we don't do anything
    function test_vaultyUnsolved() external {
        assertFalse(vaulty.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved if we call the solve function
    function test_vaultySolved() external {
        vm.startPrank(player);
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/
        vm.stopPrank();

        vm.startPrank(alice);
        vaulty.deposit{value: 15 ether}();
        vm.stopPrank();

        vm.startPrank(player);
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/
        vm.stopPrank();

        assertTrue(vaulty.isSolved());
    }
}
