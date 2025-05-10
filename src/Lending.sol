// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

Interface IAave {
    function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
}
contract Lending {
}
