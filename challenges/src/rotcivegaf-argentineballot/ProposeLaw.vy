# @version 0.3.7

"""
A propose law contract

Only the president
"""

president: public(address)

@external
def initialize():
    assert self.president == empty(address), "INITIALIZE"
    self.president = msg.sender

@external
def newElection(newPresident : address):
    assert msg.sender != tx.origin, "ORIGIN"
    self.president = newPresident
