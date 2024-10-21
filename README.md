# Morpho Token

This repository contains the latest version of the Morpho protocol’s ERC20 token, designed to enhance functionality, security, and compatibility within the Morpho ecosystem. This new version introduces upgradability and onchain delegation features, allowing for greater flexibility and adaptability over time. Additionally, it includes a wrapper contract to facilitate a seamless migration from the previous token version, enabling users to transition their assets with minimal friction.

## Upgradability

The Morpho Token leverages the eip-1967 to enable upgrade of the logic. This will allow new features to be added in the future.

## Delegation

The Morpho Token enables onchain voting power delegation. The contract keeps track of all the addresses current voting power, which allows onchain votes thanks to storage proofs (on specific voting contracts).

## Migration

### Wrapper Contract

The `Wrapper` contract is designed to facilitate the migration of legacy tokens to the new token version at a 1:1 ratio. By implementing `depositFor` and `withdrawTo` functions, this contract ensures compliance with `ERC20WrapperBundler` from the [Morpho bundler](https://github.com/morpho-org/morpho-blue-bundlers) contracts, enabling one-click migrations that simplify the transition process.
The `Wrapper` contract will hold the migrated legacy tokens.

### Migration Flow


## Usage

### Install dependencies

```shell
$ forge install
```

### Test

```shell
$ forge test
```
