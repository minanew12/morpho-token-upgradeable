// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {ERC20Upgradeable} from "lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import {Ownable2StepUpgradeable} from
    "lib/openzeppelin-contracts-upgradeable/contracts/access/Ownable2StepUpgradeable.sol";
import {ERC20VotesUpgradeable} from
    "lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import {
    ERC20PermitUpgradeable,
    NoncesUpgradeable
} from "lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol";

// TODO:
// - add natspecs
// - add events?
// - add error messages
contract MorphoToken is ERC20VotesUpgradeable, ERC20PermitUpgradeable, Ownable2StepUpgradeable {
    /* CONSTANTS */

    /// @dev the name of the token.
    string internal constant NAME = "Morpho Token";

    /// @dev the symbol of the token.
    string internal constant SYMBOL = "MORPHO";

    /* PUBLIC */

    function initialize(address dao, address wrapper) public initializer {
        require(dao != address(0), "MorphoToken: wrapper is the zero address");
        require(wrapper != address(0), "MorphoToken: wrapper is the zero address");

        ERC20VotesUpgradeable.__ERC20Votes_init_unchained();
        ERC20Upgradeable.__ERC20_init_unchained(NAME, SYMBOL);
        Ownable2StepUpgradeable.__Ownable2Step_init_unchained();
        ERC20PermitUpgradeable.__ERC20Permit_init(NAME);

        _transferOwnership(dao); // Transfer ownership to the DAO.
        _mint(wrapper, 1_000_000_000e18); // Mint 1B to the wrapper contract.
    }

    function nonces(address owner) public view override(ERC20PermitUpgradeable, NoncesUpgradeable) returns (uint256) {
        return ERC20PermitUpgradeable.nonces(owner);
    }

    /* INTERNAL */

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20Upgradeable, ERC20VotesUpgradeable)
    {
        ERC20VotesUpgradeable._update(from, to, value);
    }
}
