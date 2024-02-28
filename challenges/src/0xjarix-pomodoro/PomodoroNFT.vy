# @version 0.3.9

# Event issued on mint or transfer
event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    token_id: indexed(uint256)

event Mint:
    receiver: indexed(address)
    token_id: indexed(uint256)

# Storage
balances: public(HashMap[address, uint256])
owners: public(HashMap[uint256, address])
tokenCounter: public(uint256)
mintPrice: public(uint256)  # Fixed price for minting an NFT
pomodoro: public(address)  # Address of the Pomodoro contract

@external
def __init__(_pomodoro: address):
    self.tokenCounter = 0
    self.mintPrice = as_wei_value(0.1, "ether")
    self.pomodoro = _pomodoro

@payable
@external
def mint(_to: address):
    assert msg.value == self.mintPrice, "Incorrect value sent"
    tokenId: uint256 = self.tokenCounter
    self.balances[_to] += 1
    self.owners[tokenId] = _to
    self.tokenCounter += 1
    send(self.pomodoro, msg.value)
    log Mint(_to, tokenId)

@view
@external
def balanceOf(_owner: address) -> uint256:
    return self.balances[_owner]

@view
@external
def ownerOf(_tokenId: uint256) -> address:
    assert self.owners[_tokenId] != empty(address), "Token does not exist"
    return self.owners[_tokenId]

@external
def transferFrom(_from: address, _to: address, _tokenId: uint256):
    assert self.owners[_tokenId] == msg.sender or _from == msg.sender, "Not authorized"
    assert self.owners[_tokenId] == _from, "From address does not own the token"
    self.balances[_from] -= 1
    self.balances[_to] += 1
    self.owners[_tokenId] = _to
    log Transfer(_from, _to, _tokenId)
