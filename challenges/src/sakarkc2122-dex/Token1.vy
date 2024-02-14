# @version 0.3.10

from vyper.interfaces import ERC20
implements: ERC20

balanceOf: public(HashMap[address, uint256])
allowance: public(HashMap[address, HashMap[address, uint256]])
totalSupply: public(uint256)
name: public(immutable(String[25]))
symbol: public(immutable(String[5]))

event Transfer:
    owner: indexed(address)
    to: indexed(address)
    amount: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    amount: uint256

@external
@payable
def __init__():
    name = "Token1"
    symbol = "T1"

@external
def transfer(to: address, amount: uint256) -> bool:
    self._transfer(msg.sender, to, amount)
    return True

@external
def approve(spender: address, amount: uint256) -> bool:
    self._approve(msg.sender, spender, amount)
    return True


@external
def transferFrom(owner: address, to: address, amount: uint256) -> bool:
    self._spend_allowance(owner, msg.sender, amount)
    self._transfer(owner, to, amount)
    return True

@internal
def _transfer(owner: address, to: address, amount: uint256):
    assert owner != empty(address), "ERC20: transfer from the zero address"
    assert to != empty(address), "ERC20: transfer to the zero address"

    owner_balanceOf: uint256 = self.balanceOf[owner]
    assert owner_balanceOf >= amount, "ERC20: transfer amount exceeds balance"
    self.balanceOf[owner] = unsafe_sub(owner_balanceOf, amount)
    self.balanceOf[to] = unsafe_add(self.balanceOf[to], amount)
    log Transfer(owner, to, amount)

@external
def mint(owner: address, amount: uint256):
    self._mint(owner, amount)

@internal
def _mint(owner: address, amount: uint256):
    assert owner != empty(address), "ERC20: mint to the zero address"

    self.totalSupply += amount
    self.balanceOf[owner] = unsafe_add(self.balanceOf[owner], amount)
    log Transfer(empty(address), owner, amount)

@internal
def _approve(owner: address, spender: address, amount: uint256):
    assert owner != empty(address), "ERC20: approve from the zero address"
    assert spender != empty(address), "ERC20: approve to the zero address"

    self.allowance[owner][spender] = amount
    log Approval(owner, spender, amount)


@internal
def _spend_allowance(owner: address, spender: address, amount: uint256):
    current_allowance: uint256 = self.allowance[owner][spender]
    if (current_allowance != max_value(uint256)):
        assert current_allowance >= amount, "ERC20: insufficient allowance"
        self._approve(owner, spender, unsafe_sub(current_allowance, amount))
