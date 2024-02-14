// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SakarDEXCTFDeployer} from "script/sakarkc2122-dex/SakarDEXCTFDeployer.s.sol";
import {IDex} from "src/sakarkc2122-dex/interfaces/IDex.sol";
import {IToken1} from "src/sakarkc2122-dex/interfaces/IToken1.sol";
import {IToken2} from "src/sakarkc2122-dex/interfaces/IToken2.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/



contract PomodoroeCTFTest is Test, SakarDEXCTFDeployer {
    IDex public dex;
    IToken1 public token1;
    IToken2 public token2;

    /// @notice Deploy the ExampleCTF and the solution contract
    function setUp() public override(SakarDEXCTFDeployer) {

        address sakar = makeAddr("I am Sakar and I am deploying this CTF!");

        SakarDEXCTFDeployer.setUp();

        (address _dex, address _token1, address _token2) = deploySakarDEXCTF();

        dex = IDex(_dex);
        token1 = IToken1(_token1);
        token2 = IToken2(_token2);

        vm.startPrank(sakar);

        token1.mint(sakar, 1000);
        token2.mint(sakar, 1000);
        dex.setTokens(address(token1), address(token2));
        token1.approve(address(dex), type(uint256).max);
        token2.approve(address(dex), type(uint256).max);
        dex.addLiquidity(address(token1), 1000);
        dex.addLiquidity(address(token2), 1000);
    
        vm.stopPrank();


    }

    /// @notice Test that the ExampleCTF is unsolved if we don't do anything
    function test_sakarDEXUnsolved() external {
        address user = makeAddr("user");
        token1.mint(user, 100);
        token2.mint(user, 100);

        assertFalse(dex.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved if we call the solve function
    function test_sakarDEXSolved() external {
        address user = makeAddr("user");
        token1.mint(user, 100);
        token2.mint(user, 100);
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/

        assertTrue(dex.isSolved());
    }
}




