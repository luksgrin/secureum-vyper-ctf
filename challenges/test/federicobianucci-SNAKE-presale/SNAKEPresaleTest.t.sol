// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SNAKEPresaleDeployer} from "script/federicobianucci-SNAKE-presale/SNAKEPresaleDeployer.s.sol";
import {IPresale} from "src/federicobianucci-SNAKE-presale/interfaces/IPresale.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/


/// CTFTest to showcase the solution to the CTF
contract CTFTest is Test, SNAKEPresaleDeployer {
    IPresale public snakePresale;

    /// @notice Deploy the CTF and the solution contract
    function setUp() public override(SNAKEPresaleDeployer) {
        SNAKEPresaleDeployer.setUp();

        snakePresale = IPresale(deploySNAKEPresaleCTF());

        vm.deal(address(snakePresale), 100 ether);
    }

    /// @notice Test that the CTF is unsolved if we don't do anything
    function test_unsolved() external {
        assertFalse(snakePresale.isSolved());
    }

    /// @notice Test that the CTF is solved if we call the solve function
    function test_solved() external {
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/
        

        assertTrue(snakePresale.isSolved());
    }
}
