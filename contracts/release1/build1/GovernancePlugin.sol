// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import {SafeCastUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/math/SafeCastUpgradeable.sol";
import {IVotesUpgradeable} from "@openzeppelin/contracts-upgradeable/governance/utils/IVotesUpgradeable.sol";
import {PluginCloneable} from "@aragon/osx/core/plugin/PluginCloneable.sol";
import {IDAO} from "@aragon/osx/core/dao/IDAO.sol";
import {Proposal} from "@aragon/osx/core/plugin/proposal/Proposal.sol";

import {IMembership} from "@aragon/osx/core/plugin/membership/IMembership.sol";
import {RATIO_BASE, _applyRatioCeiled} from "@aragon/osx/plugins/utils/Ratio.sol";

contract GovernancePlugin is IMembership, Proposal, PluginCloneable {
    using SafeCastUpgradeable for uint256;

    IVotesUpgradeable private votingToken;

    function initialize(IDAO _dao, IVotesUpgradeable _token) external initializer {
        votingToken = _token;
        emit MembershipContractAnnounced({definingContract: address(_token)});
    }

    function isMember(address _account) external view returns (bool) {
        revert("not implemented");
    }

    /// @notice Checks if this or the parent contract supports an interface by its ID.
    /// @param _interfaceId The ID of the interface.
    /// @return Returns `true` if the interface is supported.
    function supportsInterface(
        bytes4 _interfaceId
    ) public view virtual override(PluginCloneable, Proposal) returns (bool) {
        return
            _interfaceId == type(IMembership).interfaceId || super.supportsInterface(_interfaceId);
    }
}
