# @version 0.3.7

"""
A simple law contract

Only the president
"""

president: public(address)

@external
def initialize():
    assert self.president == empty(address), "INITIALIZE"
    self.president = msg.sender
