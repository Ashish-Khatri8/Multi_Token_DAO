// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "@openzeppelin/contracts/governance/TimelockController.sol";


contract TimeLock is TimelockController {

    /**
     * @dev Timelock bound to a governance contract.
     * @param _minDelay Minimum delay in the number of blocks for which to wait before executing a passed proposal. 
     * @param _proposers Array of addresses that can tell the timelock to do something. Must give this role only to the DAO Governance contract.
     * @param _executors Array of addresses that can execute a passed proposal. If "null" address is given, then all addresses are set as executors.
     */
    constructor(
        uint256 _minDelay,
        address[] memory _proposers,
        address[] memory _executors
    ) TimelockController(
        _minDelay,
        _proposers,
        _executors
    ) {}
}
