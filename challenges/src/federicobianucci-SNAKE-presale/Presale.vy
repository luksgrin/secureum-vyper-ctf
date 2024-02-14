# @version 0.3.7

"""
Buy SNAKE tokens the new DOGE written in vyper! You can also refer your friends paying gas for them and get 5% of their purchase!

100 ETH has been deposited in this contract. If only there is a way to get it out before the presale ends...
"""

import interfaces.IVyperSecureumCTF as IVyperSecureumCTF
import interfaces.IWETH as IWETH

implements: IVyperSecureumCTF

# WETH address in Holesky testnet
WETH_ADDR: constant(address) = 0x6B5817E7091BC0C747741E96820b0199388245EA

owner: public(address)
presaleEnd: public(uint256)
userBalance: public(HashMap[address, uint256])
userReferral: public(address[max_value(uint256)])

event Deposit:
    user: indexed(address)
    spender: indexed(address)
    referall: indexed(address)
    amount: uint256

@external
def __init__(_presaleEnd: uint256):
    self.owner = msg.sender
    self.presaleEnd = _presaleEnd

@external
@payable
def buy():
    assert block.timestamp <= self.presaleEnd, "Presale ended"
    self.userBalance[msg.sender] += msg.value
    log Deposit(msg.sender, msg.sender, empty(address), msg.value)
    
@external
def buyOnBehalfWithPermit(_user: address, _amount: uint256, _deadline: uint256, v: uint8, r: bytes32, s: bytes32, _referralCode: uint256, _referral: address):
    IWETH(WETH_ADDR).permit(_user, self, _amount, _deadline, v, r, s)
    IWETH(WETH_ADDR).transferFrom(_user, self, _amount)
    IWETH(WETH_ADDR).withdraw(_amount)
    self.userBalance[_user] += _amount
    self.userReferral[_referralCode] = _referral
    log Deposit(_user, msg.sender, _referral, _amount)

@external
def withdraw():
    assert msg.sender == self.owner, "Not authorized"
    assert block.timestamp > self.presaleEnd, "Presale not ended"
    selfdestruct(msg.sender)

@external
def __default__():
    pass

@external
@view
def isSolved() -> bool:
    return self.balance == 0 and msg.sender.balance >= 100 * 10 ** 18
