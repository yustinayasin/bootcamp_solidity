// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MockUSDC} from "../src/MockUSDC.sol"; 
import {Vault} from "../src/Vault.sol"; 

contract VaultTest is Test {
    MockUSDC public usdc;
    Vault public vault;

    address public alice = makeAddr("Alice");
    address public bob = makeAddr("Bob");
    address public charlie = makeAddr("Charlie");

    function setUp() public {
        usdc = new MockUSDC();
        vault = new Vault(address(usdc));
    }

    function test_Deposit() public {
        vm.startPrank(alice);
        usdc.mint(alice, 1000);
        usdc.approve(address(vault), 1000); // usdc approve buat depositin
        vault.deposit(1000);
        assertEq(vault.balanceOf(alice), 1000); // cek shares vault alice
        vm.stopPrank();

        vm.startPrank(bob);
        usdc.mint(bob, 2000);
        usdc.approve(address(vault), 2000);
        vault.deposit(2000);
        assertEq(vault.balanceOf(bob), 2000);
        vm.stopPrank();

        vm.startPrank(charlie);
        usdc.mint(charlie, 3000);
        usdc.approve(address(vault), 3000);
        vault.deposit(3000);
        assertEq(vault.balanceOf(charlie), 3000);
        vm.stopPrank();
    }

    function test_scenario() public {
        // alice deposit 1jt
        vm.startPrank(alice);
        usdc.mint(alice, 1_000_000);
        usdc.approve(address(vault), 1_000_000);
        vault.deposit(1_000_000);
        assertEq(vault.balanceOf(alice), 1_000_000);
        vm.stopPrank();

        // bob deposit 2 jt
        vm.startPrank(bob);
        usdc.mint(bob, 2_000_000);
        usdc.approve(address(vault), 2_000_000);
        vault.deposit(2_000_000);
        assertEq(vault.balanceOf(bob), 2_000_000);
        vm.stopPrank();

        // distribute yield 1 jt
        usdc.mint(address(this), 1_000_000); // seolah-olah ke alamat managernya
        usdc.approve(address(vault), 1_000_000);
        vault.distributeYield(1_000_000);

        // charlie deposit 1 jt
        vm.startPrank(charlie);
        usdc.mint(charlie, 1_000_000);
        usdc.approve(address(vault), 1_000_000);
        vault.deposit(1_000_000);
        assertEq(vault.balanceOf(charlie), 750_000); // shares of charlie 
        vm.stopPrank();

        // alice withdraw seluruh sharesnya
        vm.startPrank(alice);
        vault.withdraw(1_000_000);
        assertEq(usdc.balanceOf(alice), 1_333_333);
        vm.stopPrank();

        // bob withdraw seluruh sharesnya
        vm.startPrank(bob);
        vault.withdraw(2_000_000);
        assertEq(usdc.balanceOf(bob), 2_666_666);
        vm.stopPrank();
    }
}
