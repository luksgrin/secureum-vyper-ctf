#pragma version 0.3.10

import interfaces.IVyperSecureumCTF as IVyperSecureumCTF

interface IVyperSecureumCTF:
    @external
    def isSolved() -> bool:
        """
        Returns whether the challenge has been solved or not.
        """
        pass
