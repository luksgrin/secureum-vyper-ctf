# @version 0.3.0
# The initial price is 2. The target is to make the price of 1 share > 10 assets.

from vyper.interfaces import ERC20

balances: public(HashMap[address, uint256])
token: public(address)
total_shares: public(uint256)
total_assets: public(uint256)

# 1. suppose decimal 18
# 2. initial price is 2
@internal
@view
def _convertToShares(assets: uint256, _ceil: bool) -> uint256:
    total_shares: uint256 = self.total_shares + 1
    total_assets: uint256 = self.total_assets + 2

    if _ceil:
        if total_shares % total_assets == 0:
            return total_shares * assets / total_assets
        else:
            return total_shares * assets / total_assets + 1
    else:
        return total_shares * assets / total_assets

@internal
@view
def _convertToAssets(shares: uint256) -> uint256:
    total_shares: uint256 = self.total_shares
    total_assets: uint256 = self.total_assets
    return shares * (total_assets + 2) / (total_shares + 1)

@external
def __init__(token: address):
    self.token = token

@external
def deposit(assets: uint256, to: address) -> uint256:
    ERC20(self.token).transferFrom(msg.sender, self, assets)
    shares: uint256 = self._convertToShares(assets, False)

    self.total_assets += assets
    self.total_shares += shares
    self.balances[to] += shares

    return shares

@external
def withdraw(assets: uint256, to: address) -> uint256:
    shares: uint256 = self._convertToShares(assets, True)

    self.total_assets -= assets
    self.total_shares -= shares
    self.balances[msg.sender] -= shares

    ERC20(self.token).transfer(to, assets)
    return shares

@external
def convertToAssets(shares: uint256) -> uint256:
    return self._convertToAssets(shares)

@external
@view
def isSolved() -> bool:
    return self._convertToAssets(1) > 20
