// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {CTFDeployer} from "script/qzpm/CTFDeployer.s.sol";
import {ICTFVy} from "src/qzpm/interfaces/ICTFVy.sol";
import {MockERC20} from "src/qzpm/MockERC20.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/



/// ExampleCTFTest to showcase the solution to the ExampleCTF
contract ExampleCTFTest is Test, CTFDeployer {
    ICTFVy public vyperSecureumCTF;
    MockERC20 public assetToken;
    address public ctf;
    address public alice = address(0x1);

    /// @notice Deploy the ExampleCTF
    function setUp() public override(CTFDeployer) {

        CTFDeployer.setUp();

        (assetToken, ctf) = CTFDeployer.deployCTF();
        vyperSecureumCTF = ICTFVy(ctf);

        // vm.deal(address(vyperSecureumCTF), 1 ether);
    }

    function test_deposit_initial_price_is_two() external {
        uint256 amount = 100;
        assetToken.faucet(address(this), amount);
        assetToken.approve(address(vyperSecureumCTF), amount);
        vyperSecureumCTF.deposit(amount, alice);
        assertEq(vyperSecureumCTF.balances(alice), amount / 2);
    }

    /// @notice Test that the ExampleCTF is unsolved if we don't do anything
    function test_unsolved() external {
        assertFalse(vyperSecureumCTF.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved if we call the solve function
    function test_solved() external {
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/

        assertTrue(vyperSecureumCTF.isSolved());
    }
}
