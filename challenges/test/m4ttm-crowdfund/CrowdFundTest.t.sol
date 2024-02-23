// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {CrowdFundDeployer} from "script/m4ttm-crowdfund/CrowdFundDeployer.s.sol";
import {ICrowdFund} from "src/m4ttm-crowdfund/interfaces/ICrowdFund.sol";

/*///////////////////////////////////////////////
// Import dependencies for your solution here! //
//             (if you need any)               //
///////////////////////////////////////////////*/



contract CrowdfundTest is Test, CrowdFundDeployer {
    ICrowdFund public crowdfund;

    address player = address(420);

    address[5] public accounts = [
        makeAddr("Alice"),
        makeAddr("Bob"),
        makeAddr("Charlie"),
        makeAddr("Denise"),
        makeAddr("Eve")
    ];

    /// @notice Deploy the ExampleCTF and the solution contract
    function setUp() public override(CrowdFundDeployer) {

        CrowdFundDeployer.setUp();

        crowdfund = ICrowdFund(deployCrowdFund(player));

        // 5 Accounts Buy 0.1 Ether
        for (uint256 i; i < accounts.length; i++) {
            vm.deal(accounts[i], 1 ether);
            vm.startPrank(accounts[i]);
            crowdfund.buy{value: 0.1 ether}(accounts[i]);
            vm.stopPrank();
        }

        vm.startPrank(player);
        for (uint256 i; i < accounts.length; i++) {
            crowdfund.approveMax(accounts[i], player);
            require(crowdfund.allowance(accounts[i], player) > 0);
        }

    }

    /// @notice Test that the ExampleCTF is unsolved if we don't do anything
    function test_crowdfundUnsolved() external {
        assertFalse(crowdfund.isSolved());
    }

    /// @notice Test that the ExampleCTF is solved if we call the solve function
    function test_crowdfundSolved() external {
        /*//////////////////////////////////////
        //     Write your solution here       //
        //////////////////////////////////////*/

        assertTrue(crowdfund.isSolved());
    }
}
