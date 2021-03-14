// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

contract MyOwnable {
    address payable public _owner;
    
    constructor() {
        _owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == _owner, "You are not the owner");
        _;
    }
    
    function isOwner() public view returns(bool) {
        return (msg.sender == _owner);
    }
}
