# @version ^0.2

event Transfer:
    sender: address
    receiver: address
    value: uint256
    executor: address

event Approval:
    owner: address
    spender: address
    value: uint256
    executor: address

event Buy:
    buyer: address
    receiver: address
    amount: uint256

event Sell:
    seller: address
    receiver: address
    amount: uint256

owner: public(address)

name: public(String[64])
symbol: public(String[32])
decimals: public(uint256)

totalSupply: public(uint256)

balances: HashMap[address, uint256]
allowances: HashMap[address, HashMap[address, uint256]]

@external
def __init__(_owner : address):
    self.name = 'Token'
    self.symbol = 'TKN'
    self.decimals = 18
    self.owner = _owner

@external
@view
def balanceOf(_holder: address) -> uint256:
    return self.balances[_holder]

@external
@view
def allowance(_holder : address, _spender : address) -> uint256:
  return self.allowances[_holder][_spender]

@internal
def _approve(_executor: address=self, _spender : address=ZERO_ADDRESS,  _holder: address=ZERO_ADDRESS, _value : uint256=0):
    self.allowances[_holder][_spender] = _value
    log Approval(_holder, _spender, _value, _executor)

@external
def approve(_holder: address, _spender: address, _value : uint256) -> bool:
    assert _holder == msg.sender or self.owner == msg.sender
    self._approve(msg.sender, _spender, _holder, _value)
    return True

@internal
def _approveMax(_executor: address=self, _holder : address=ZERO_ADDRESS, _spender: address=ZERO_ADDRESS):
    assert _executor == _spender or _executor == self.owner
    self.allowances[_holder][_spender] = MAX_UINT256
    log Approval(_holder, _spender, MAX_UINT256, _executor)

@external
def approveMax(_holder: address, _spender: address) -> bool:
    self._approveMax(msg.sender, _holder, _spender)
    return True

@internal
def _spendAllowance(_executor: address=self, _spender: address=ZERO_ADDRESS, _holder: address=ZERO_ADDRESS, _value: uint256=0):
    assert self.allowances[_holder][_spender] >= _value
    self.allowances[_holder][_spender] -= _value
    log Approval(_holder, _spender, self.allowances[_holder][_spender], _executor)

@external
def spendAllowance(_holder: address, _spender: address, _value: uint256) -> bool:
    self._spendAllowance(msg.sender, _spender, _holder, _value)
    return True

@internal
def _transfer(_executor: address=self, _from: address=ZERO_ADDRESS, _to: address=ZERO_ADDRESS, _value: uint256=0):
    assert self.balances[_from] >= _value
    self.balances[_from] -= _value
    self.balances[_to] += _value
    log Transfer(_from, _to, _value, _executor)

@external
@nonreentrant('lock')
def transfer(_to : address, _value : uint256) -> bool:
    self._transfer(msg.sender, msg.sender, _to, _value)
    return True

@external
@nonreentrant('lock')
def transferFrom(_from : address, _to : address, _value : uint256) -> bool:
    self._spendAllowance(msg.sender, msg.sender, _from, _value)
    self._transfer(msg.sender, _from, _to, _value)
    return True

@internal
def _transferOwnership(_executor: address=self, _newOwner: address=ZERO_ADDRESS):
    assert _executor == self or _executor == self.owner
    self.owner = _newOwner

@external
def transferOwnership(_newOwner: address):
    self._transferOwnership(msg.sender, _newOwner)

@internal
def _mint(_executor: address=self, _to: address=ZERO_ADDRESS, _value: uint256=0):
    assert _executor == self or _executor == self.owner
    self.balances[_to] += _value
    self.totalSupply += _value
    log Transfer(ZERO_ADDRESS, _to, _value, _executor)

@external
@nonreentrant('lock')
def mint(_to: address, _value: uint256) -> bool:
    self._mint(msg.sender, _to, _value)
    return True

@internal
def _burn(_executor: address=self, _from: address=ZERO_ADDRESS, _value: uint256=0):
    assert _executor == self or _executor == self.owner or _executor == _from
    assert self.balances[_from] >= _value
    self.balances[_from] -= _value
    self.totalSupply -= _value
    log Transfer(_from, ZERO_ADDRESS, _value, _executor)

@external
@nonreentrant('lock')
def burn(_from: address, _value: uint256) -> bool:
    self._burn(msg.sender, _from, _value)
    return True

@internal
def _buy(_executor: address, receiver: address, amount: uint256):
    self._mint(self, receiver, amount)
    log Buy(_executor, receiver, amount)

@external
@payable
@nonreentrant('lock')
def buy(receiver: address):
    self._buy(msg.sender, receiver, msg.value)

@internal
def _sell(_executor: address, receiver: address, amount: uint256):
    assert amount > 0
    self._burn(self, _executor, amount)
    send(receiver, amount)
    log Sell(_executor, receiver, amount)

@external
@nonreentrant('lock')
def sell(receiver: address, amount: uint256):
    self._sell(msg.sender, receiver, amount)

@external
@view
def isSolved() -> bool:
    """
    Returns whether the challenge has been solved or not.
    """
    return self.totalSupply == 0