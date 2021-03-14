// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

import "./ItemManager.sol";


contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;
    
    ItemManager parentContract;
    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }
    
    receive() external payable {
        require(pricePaid ==0, "Item is paid already");
        require(priceInWei == msg.value, "Only full payments allowed");
        pricePaid += msg.value;
        // fix amount of gas, need to use call instead
        // payable(address(parentContract)).transfer(msg.value);
        
        // This can specify the gas. has to call triggerPayment signature
        // crucial to listen to retrn value, b/c/ call() do NOT throw an exception
        // address(parentContract).call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)", index));
        (bool success,) = address(parentContract).call {value: msg.value} (abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "The transaction was not successfull, cancelling");
    }
    
    fallback() external {}
}