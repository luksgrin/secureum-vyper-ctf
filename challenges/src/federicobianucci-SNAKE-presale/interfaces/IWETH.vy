# @version 0.3.7

@external
@payable
def deposit():
    pass

@external
def withdraw(_amount: uint256):
    pass

@external
def transferFrom(_from: address, _to: address, _amount: uint256):
    pass

@external
def permit(_owner: address, _spender: address, _value: uint256, _deadline: uint256, _v: uint8, _r: bytes32, _s: bytes32):
    pass