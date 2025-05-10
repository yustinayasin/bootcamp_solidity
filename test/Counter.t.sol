// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol"; // file yang akan ditest

contract CounterTest is Test {
    Counter public counter;

    address public alice = makeAddr("Alice"); // buat akun baru nama alice

    function setUp() public { // deploy contract, dieksekusi sebelum tes lainnya
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_SetPrice() public {
        vm.prank(alice); // login sebagai alice
        vm.expectRevert("Only owner can set the price"); // message error harus sama kyak yang di function
        counter.setPrice(100);

        vm.prank(address(this));
        counter.setPrice(100);
        assertEq(counter.price(), 100);
        console.log("Price set to 100");
    }

    function test_Increment() public { // standar penamaan test 
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
