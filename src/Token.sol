// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("Yustina", "Yasin") {

    }

    function mint(address to, uint256 amount) public { // mint artinya mencetak uang
        _mint(to, amount);
    }
}
