# @version 0.3.10

interface IERC20:
    def totalSupply() -> uint256: view
    def balanceOf(account: address) -> uint256: view
    def transfer(recipient: address, amount: uint256) -> bool: nonpayable
    def allowance(owner: address, spender: address) -> uint256: view
    def approve(spender: address, amount: uint256) -> bool: nonpayable
    def transferFrom(sender: address, recipient: address, amount: uint256) -> bool: nonpayable

interface IVyperSecureumCTF:
    def isSolved() -> bool: view

interface ITokens:
    def approve(owner: address, spender: address, amount: uint256): nonpayable

token1: public(address)
token2: public(address)
solved: public(bool)

@external
def setTokens(_token1: address, _token2: address):
    self.token1 = _token1
    self.token2 = _token2

@external
def addLiquidity(tokenAddress: address, amount: uint256):
    IERC20(tokenAddress).transferFrom(msg.sender, self, amount)

@external
def swap(sender: address, receiver: address, amount: uint256):
    if (sender == self.token1) and (receiver == self.token2):
        pass
    elif (sender == self.token2) and (receiver == self.token1):
        pass
    else:
        raise "Invalid Token"
    
    assert IERC20(sender).balanceOf(msg.sender) >= amount, "Not enough to swap"
    swapAmount: uint256 = self.getSwapPrice(sender, receiver, amount)
    IERC20(sender).transferFrom(msg.sender, self, amount)
    IERC20(receiver).approve(self, swapAmount)
    IERC20(receiver).transferFrom(self, msg.sender, swapAmount)

@internal
@view
def getSwapPrice(fromToken: address, toToken: address, amount: uint256) -> uint256:
    return (amount * IERC20(toToken).balanceOf(self)) / IERC20(fromToken).balanceOf(self)

@external
def approve(spender: address, amount: uint256):
    ITokens(self.token1).approve(msg.sender, spender, amount)
    ITokens(self.token2).approve(msg.sender, spender, amount)

@external
@view
def balanceOf(token: address, account: address) -> uint256:
    return IERC20(token).balanceOf(account)

@external
def solve():
    if (IERC20(self.token1).balanceOf(self) == 0) and (IERC20(self.token2).balanceOf(self) == 0):
        self.solved = True

@external
def isSolved() -> bool:
    return self.solved == True