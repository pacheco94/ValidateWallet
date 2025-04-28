// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ValidateWallet} from "../src/ValidateWallet.sol";

contract ValidateWalletScript is Script {
    ValidateWallet public validateWallet;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        validateWallet = new ValidateWallet();
        console.log("ValidateWallet deployed to:", address(validateWallet));

        vm.stopBroadcast();
    }
}
