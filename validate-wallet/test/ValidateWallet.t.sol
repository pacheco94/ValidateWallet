// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ValidateWallet} from "../src/ValidateWallet.sol";

contract ValidatWalletTest is Test {
    ValidateWallet public validateWallet;

    address owner = address(0x1);
    address user1 = address(0x2);
    address user2 = address(0x3);

    function setUp() public {
        vm.startPrank(owner);
        validateWallet = new ValidateWallet();
        vm.stopPrank();
    }

    function testAddUserSuccess() public {
        vm.startPrank(user1);
        validateWallet.addUser("Andres", "Rodriguez", user1);

        ValidateWallet.User memory user = validateWallet.getUserByAddress(
            user1
        );
        assertEq(user.name, "Andres");
        assertEq(user.firstName, "Rodriguez");
        assertEq(user.walletAddress, user1);
        assertEq(user.id, 0);
        assertEq(validateWallet.userCount(), 1);
        assertEq(validateWallet.isWalletValidated(user1), true);
        vm.stopPrank();
    }

    function testUserAlreadyValidated() public {
        vm.startPrank(user1);
        validateWallet.addUser("Andres", "Rodrigues", user1);
        vm.expectRevert("Wallet already validated");
        validateWallet.addUser("Bob", "Jones", user1);
        vm.stopPrank();
    }

    function testGetingUserByAddress() public {
        vm.startPrank(user2);
        validateWallet.addUser("Sofia", "Anderson", user2);
        ValidateWallet.User memory user = validateWallet.getUserByAddress(
            user2
        );
        assertEq(user.name, "Sofia");
        assertEq(user.firstName, "Anderson");
        assertEq(user.walletAddress, user2);
        assertEq(user.id, 0);
        assertEq(validateWallet.userCount(), 1);
        assertEq(validateWallet.isWalletValidated(user2), true);
        vm.stopPrank();
    }
    function testGetUserByAddresFiledUnauthorized() public {
        vm.prank(user1);
        validateWallet.addUser("Alice", "Smith", user1);

        // Attempt to get user by address from a different address
        vm.expectRevert("Not authorized");
        vm.prank(user2);
        validateWallet.getUserByAddress(user1);
    }

    function testGetUserByAddressFiledNotFound() public {
        vm.expectRevert("Wallet not found");
        vm.prank(user1);
        validateWallet.getUserByAddress(user1);
    }

    function testGetUserById() public {
        vm.startPrank(owner);
        validateWallet.addUser("Alice", "Smith", user1);

        // Only the owner can get user by id
        ValidateWallet.User memory user = validateWallet.getUserById(0);
        assertEq(user.name, "Alice");
        assertEq(user.firstName, "Smith");
        assertEq(user.walletAddress, user1);
        vm.stopPrank();
    }

    function testGetUserByIdFiledNotFound() public {
        vm.startPrank(owner);
        vm.expectRevert("User not found");
        validateWallet.getUserById(6);
        vm.stopPrank();
    }

    function testGetUserByIdFiledUserNotFound() public {
        vm.startPrank(owner);
        validateWallet.addUser("Alice", "Smith", user1);
        vm.expectRevert("User not found");
        validateWallet.getUserById(99);
        vm.stopPrank();
    }

    function testUserCountIncrement() public {
        vm.prank(user1);
        validateWallet.addUser("Alice", "Smith", user1);

        vm.prank(user2);
        validateWallet.addUser("Bob", "McDonals", user2);

        // Secound user should have id 1
        vm.startPrank(owner);
        ValidateWallet.User memory user = validateWallet.getUserById(1);
        assertEq(user.id, 1);
        vm.stopPrank();
    }
}
