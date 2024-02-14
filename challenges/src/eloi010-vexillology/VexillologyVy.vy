#pragma version 0.3.10

"""
@title Vexillology
@license UNLICENSED
@author Eloi Manuel
@notice Vyper challenge for the Secureum
@dev
    We are making sure our flag is always in the right position and never captured.
    For this, we have implemented a FREI-PI pattern. We make sure our invariant always
    holds: "The flag should never be CAPTURED".
    See:
        - https://www.nascent.xyz/idea/youre-writing-require-statements-wrong
        - https://x.com/PatrickAlphaC/status/1676969198663401472
"""

import interfaces.IVexillologyVy as IVexillologyVy

implements: IVexillologyVy

# Vexillology params for a country
enum Flag:
    FOLDED
    HOISTED
    INVERTED
    HALF_MAST
    CAPTURED

country_name: public(String[100])
country_flag: public(Flag)

event FlagFolded:
    folded: bool
event FlagHoisted:
    hoisted: bool
event FlagInverted:
    inverted: bool
event FlagHalfMasted:
    half_masted: bool

# Create a new country with its name
# and its folded flag
@external
def __init__(_country: String[100]):
    self.country_name = _country
    self.country_flag = Flag.FOLDED
    log FlagFolded(True)
    assert self.country_flag != Flag.CAPTURED, "Making sure flag is not captured"

@external
def hoist_flag():
    """
    @notice Set the flag to hoisted when folded
    @notice We always follow the the FREI-PI pattern
    """
    assert self.country_flag == Flag.FOLDED, "Flag not folded"
    self.country_flag = Flag.HOISTED
    log FlagHoisted(True)
    assert self.country_flag != Flag.CAPTURED, "Making sure flag is not captured"

@external
def invert_flag():
    """
    @notice Set the flag to inverted when hoisted
    @notice We always follow the the FREI-PI pattern
    """
    assert self.country_flag == Flag.HOISTED, "Flag not hoisted"
    self.country_flag = ~Flag.INVERTED
    log FlagInverted(True)
    assert self.country_flag != Flag.CAPTURED, "Making sure flag is not captured"

@external
def half_mast_flag():
    """
    @notice Set the flag to half-mast when not inverted
    @notice We always follow the the FREI-PI pattern
    """
    assert self.country_flag != Flag.INVERTED, "Flag is inverted"
    self.country_flag = Flag.HALF_MAST
    log FlagHalfMasted(True)
    assert self.country_flag != Flag.CAPTURED, "Making sure flag is not captured"

@external
def set_captured():
    """
    @notice Set the flag to captured
    @notice We always follow the the FREI-PI pattern
    """
    assert self.country_flag != Flag.CAPTURED, "Making sure flag is not captured"
    raw_revert(_abi_encode("We will never surrender"))

@external
def reset_flag():
    """
    @notice Set the flag back to folded
    @notice We always follow the the FREI-PI pattern
    """
    self.country_flag = Flag.FOLDED
    log FlagFolded(True)
    assert self.country_flag != Flag.CAPTURED, "Making sure flag is not captured"

@external
@view
def isSolved() -> bool:
    """
    @notice Returns whether the challenge has been solved or not.
    """
    return self.country_flag in Flag.CAPTURED
