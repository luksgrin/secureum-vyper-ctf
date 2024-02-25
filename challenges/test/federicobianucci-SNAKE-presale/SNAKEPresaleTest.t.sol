// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SNAKEPresaleDeployer} from "script/federicobianucci-SNAKE-presale/SNAKEPresaleDeployer.s.sol";
import {IPresale} from "src/federicobianucci-SNAKE-presale/interfaces/IPresale.sol";
import {IWETH} from "src/federicobianucci-SNAKE-presale/interfaces/IWETH.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/


/// CTFTest to showcase the solution to the CTF
contract CTFTest is Test, SNAKEPresaleDeployer {
    IPresale public snakePresale;
    IWETH public weth9 = IWETH(0x6B5817E7091BC0C747741E96820b0199388245EA);

    /// @notice Deploy the CTF and the solution contract
    function setUp() public override(SNAKEPresaleDeployer) {
        etch_weth9_code();
        SNAKEPresaleDeployer.setUp();

        snakePresale = IPresale(deploySNAKEPresaleCTF());

        vm.deal(address(snakePresale), 100 ether);
    }

    /// @notice Etch weth9 bytes into its address for local testing
    function etch_weth9_code() private {
        vm.etch(
            address(weth9),
            vm.parseBytes(vm.readFile(
                "src/federicobianucci-SNAKE-presale/WETH9.bin"
            ))
        );
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
