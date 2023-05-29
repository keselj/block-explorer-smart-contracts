// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.11;

contract VendingMachine {
    address public owner;
    mapping (address => uint) public donutBalances;

    constructor () {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    } 

    function getBalance() public view returns(uint) {
        return donutBalances[address(this)];
    }

    function restock(uint _amount) public {
        require(msg.sender == owner, "Only thw owner restock this machine.");
        donutBalances[address(this)] += _amount;
    }

    function purchase(uint _amount) public payable {
        require(msg.value >= _amount * 2 ether, "You must pay at least 2 ether per donut!");
        require(donutBalances[address(this)] >= _amount, "Not enough donuts in stock.");
        donutBalances[address(this)] -= _amount;
        donutBalances[msg.sender] += _amount;

    }
}