# @version 0.3.10

from vyper.interfaces import ERC20
implements: ERC20

interface FlashLoanReceiver:
    def onFlashLoan(): payable

INITIAL_RATE: constant(uint256) = 10**9

balanceOf: public(HashMap[address, uint256])
allowance: public(HashMap[address, HashMap[address, uint256]])
totalSupply: public(uint256)
totalAssets: public(uint256)
owner: public(address)
rewarders: public(HashMap[address, bool])

event Transfer:
    owner: indexed(address)
    to: indexed(address)
    amount: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    amount: uint256

@external
def __init__():
    self.owner = msg.sender

@external
@payable
@nonreentrant("lock")
def deposit() -> uint256:
    supply: uint256 = self.totalSupply
    assets: uint256 = self.totalAssets
    shares: uint256 = empty(uint256)

    if supply == 0:
        assert msg.value >= INITIAL_RATE
        shares = unsafe_div(msg.value, INITIAL_RATE)
    else:
        shares = unsafe_div(msg.value * supply, assets)

    self.totalAssets = unsafe_add(assets, msg.value)
    self.totalSupply = supply + shares
    self.balanceOf[msg.sender] = unsafe_add(self.balanceOf[msg.sender], shares)

    log Transfer(empty(address), msg.sender, shares)

    return shares

@external
@nonreentrant("lock")
def withdraw(shares: uint256) -> uint256:
    supply: uint256 = self.totalSupply
    assets: uint256 = self.totalAssets
    amount: uint256 = unsafe_div(shares * assets, supply)

    self.totalAssets = unsafe_sub(assets, amount)
    self.totalSupply = unsafe_sub(supply, shares)
    self.balanceOf[msg.sender] -= shares

    raw_call(msg.sender, b"", value=amount)

    log Transfer(msg.sender, empty(address), shares)

    return amount

@external
@nonreentrant("lock")
def flashLoan(receiver: address, amount: uint256):
    balance_before: uint256 = self.balance
    FlashLoanReceiver(receiver).onFlashLoan(value=amount)
    assert self.balance >= balance_before

@external
@payable
def assignRewards():
    assert self.rewarders[msg.sender], "not rewarder"
    self.totalAssets = unsafe_add(self.totalAssets, msg.value)

@external
def transfer(to: address, amount: uint256) -> bool:
    self.balanceOf[msg.sender] -= amount
    self.balanceOf[to] = unsafe_add(self.balanceOf[to], amount)
    log Transfer(msg.sender, to, amount)
    return True

@external
def approve(spender: address, amount: uint256) -> bool:
    self.allowance[msg.sender][spender] = amount
    log Approval(msg.sender, spender, amount)
    return True

@external
def transferFrom(owner: address, to: address, amount: uint256) -> bool:
    allowance: uint256 = self.allowance[owner][msg.sender]
    if (allowance != max_value(uint256)):
        new_amount: uint256 = allowance - amount
        self.allowance[owner][msg.sender] = new_amount
        log Approval(owner, msg.sender, new_amount)
    self.balanceOf[owner] = self.balanceOf[owner] - amount
    self.balanceOf[to] = unsafe_add(self.balanceOf[to], amount)
    log Transfer(owner, to, amount)
    return True

@external
@view
def decimals() -> uint8:
    return 18

@external
def setRewarder(account: address, enabled: bool):
    assert self.owner == msg.sender, "not owner"
    self.rewarders[account] = enabled

@external
@payable
def __default__():
    pass

@external
@view
def isSolved() -> bool:
    return self.balance == 0