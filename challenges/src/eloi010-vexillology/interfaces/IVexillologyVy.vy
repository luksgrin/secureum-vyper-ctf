#pragma version 0.3.10

import interfaces.IVyperSecureumCTF as IVyperSecureumCTF

event FlagFolded:
    folded: bool
event FlagHoisted:
    hoisted: bool
event FlagInverted:
    inverted: bool
event FlagHalfMasted:
    half_masted: bool

interface IVexillologyVy:
    @external
    def hoist_flag():
        """
        @notice Set the flag to hoisted when folded
        """
        pass

    @external
    def invert_flag():
        """
        @notice Set the flag to inverted when hoisted
        """
        pass

    @external
    def half_mast_flag():
        """
        @notice Set the flag to half-mast when not inverted
        """
        pass

    @external
    def set_captured():
        """
        @notice Set the flag to captured
        """
        pass

    @external
    def reset_flag():
        """
        @notice Set the flag back to folded
        """
        pass
