// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogicContract {
    uint public value;

    function updateValue(uint _newValue) external {
        value = _newValue;
    }
}

contract ProxyContract {
    address public logicContract;

    constructor(address _logicContract) {
        logicContract = _logicContract;
    }

    function updateValue(uint _newValue) external {
        (bool success, ) = logicContract.delegatecall(abi.encodeWithSignature("updateValue(uint256)", _newValue));
        require(success, "Update failed");
    }
}

