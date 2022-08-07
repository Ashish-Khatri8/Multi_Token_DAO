// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;


import "./governance/extensions/GovernorVotes.sol";
import "./governance/extensions/GovernorVotesQuorumFraction.sol";
import "./governance/extensions/GovernorPreventLateQuorum.sol";
import "./governance/Governor.sol";
import "./governance/extensions/GovernorTimelockControl.sol";
import "./governance/extensions/GovernorCountingSimple.sol";
import "./governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/utils/IVotes.sol";


/// @title MultiTokenDAO
/// @author Ashish Khatri
contract MultiTokenDAO is 
    Governor,
    GovernorVotes,
    GovernorVotesQuorumFraction,
    GovernorPreventLateQuorum, 
    GovernorCountingSimple,
    GovernorSettings,
    GovernorTimelockControl {

        constructor(
            string memory _name,
            IVotes[] memory _votingTokens,
            uint256 _quorumPercentage,
            uint64 _initialVoteExtension,
            uint256 _votingDelay,
            uint256 _votingPeriod,
            uint256 _proposalThreshold,
            TimelockController _timelock
        ) 
            Governor(_name)
            GovernorVotes(_votingTokens)
            GovernorVotesQuorumFraction(_quorumPercentage)
            GovernorPreventLateQuorum(_initialVoteExtension)
            GovernorTimelockControl(_timelock)
            GovernorSettings(_votingDelay, _votingPeriod, _proposalThreshold)
            {}

        /* 
            All the functions below are required to be override as they are 
            present in two or more base contracts.
        */ 
        function _cancel(
            address[] memory targets,
            uint256[] memory values,
            bytes[] memory calldatas,
            bytes32 descriptionHash
        ) internal override(Governor, GovernorTimelockControl) returns(uint256) {
            return super._cancel(targets, values, calldatas, descriptionHash);
        }

        function _execute(
            uint256 proposalId,
            address[] memory targets,
            uint256[] memory values,
            bytes[] memory calldatas,
            bytes32 descriptionHash
        ) internal override(Governor, GovernorTimelockControl) {
            super._execute(proposalId, targets, values, calldatas, descriptionHash);
        }

        function _executor() internal view override(Governor, GovernorTimelockControl) returns(address) {
            return super._executor();
        }

        function proposalThreshold() public view override(Governor, GovernorSettings) returns(uint256) {
            return super.proposalThreshold();
        }

        function state(
            uint256 proposalId
        ) public view override(Governor, GovernorTimelockControl) returns(ProposalState) {
            return super.state(proposalId);
        }

        function supportsInterface(
            bytes4 interfaceId
        ) public view override(Governor, GovernorTimelockControl) returns(bool) {
            return super.supportsInterface(interfaceId);
        }
        
        function _castVote(
            uint8 tokenIndex,
            uint256 proposalId,
            address account,
            uint8 support,
            string memory reason,
            bytes memory params
        ) internal virtual override(Governor, GovernorPreventLateQuorum) returns (uint256) {
            return super._castVote(tokenIndex, proposalId, account, support, reason, params);
        }

        function proposalDeadline(uint256 proposalId) public view virtual override(Governor, IGovernor, GovernorPreventLateQuorum) returns (uint256) {
            return super.proposalDeadline(proposalId);
        }
}
