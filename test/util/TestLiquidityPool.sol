/*
 * Copyright 2024 Circle Internet Group, Inc. All rights reserved.

 * SPDX-License-Identifier: GPL-3.0-or-later

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// for the simplicity, TestLiquidityPool is ERC20
contract TestLiquidityPool is ERC20 {
    event ReceiveETH(address indexed from, uint256 indexed value);

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }

    function supplyLiquidity(address from, address to, uint256 amount) public returns (bool) {
        address spender = address(this);
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    receive() external payable {
        emit ReceiveETH(msg.sender, msg.value);
    }
}
