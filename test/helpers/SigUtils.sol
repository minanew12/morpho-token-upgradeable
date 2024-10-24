// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {IERC5267} from
    "lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol";

library SigUtils {
    struct Delegation {
        address delegatee;
        uint256 nonce;
        uint256 expiry;
    }

    struct Permit {
        address owner;
        address spender;
        uint256 value;
        uint256 nonce;
        uint256 deadline;
    }

    bytes32 private constant DELEGATION_TYPEHASH =
        keccak256("Delegation(address delegatee,uint256 nonce,uint256 expiry)");

    bytes32 private constant PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    bytes32 private constant TYPE_HASH =
        keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");

    // bytes32 private constant DOMAIN_SEPARATOR = 0xebe7cdc854ed987c1fb2e9e58acbe8b1afdc4375c51e160b9a8de75014baa36b;

    /// @dev Computes the hash of the EIP-712 encoded data.
    function getDelegationTypedDataHash(Delegation memory delegation, address contractAddress)
        public
        view
        returns (bytes32)
    {
        (, string memory name, string memory version,,,,) = IERC5267(contractAddress).eip712Domain();
        return keccak256(
            bytes.concat("\x19\x01", domainSeparator(contractAddress, name, version), delegationHashStruct(delegation))
        );
    }

    function getPermitTypedDataHash(Permit memory permit, address contractAddress) public view returns (bytes32) {
        (, string memory name, string memory version,,,,) = IERC5267(contractAddress).eip712Domain();
        return keccak256(
            bytes.concat("\x19\x01", domainSeparator(contractAddress, name, version), permitHashStruct(permit))
        );
    }

    function delegationHashStruct(Delegation memory delegation) internal pure returns (bytes32) {
        return keccak256(abi.encode(DELEGATION_TYPEHASH, delegation.delegatee, delegation.nonce, delegation.expiry));
    }

    function permitHashStruct(Permit memory permit) internal pure returns (bytes32) {
        return keccak256(
            abi.encode(PERMIT_TYPEHASH, permit.owner, permit.spender, permit.value, permit.nonce, permit.deadline)
        );
    }

    function domainSeparator(address contractAddress, string memory name, string memory version)
        public
        view
        returns (bytes32)
    {
        return keccak256(
            abi.encode(TYPE_HASH, keccak256(bytes(name)), keccak256(bytes(version)), block.chainid, contractAddress)
        );
    }
}
