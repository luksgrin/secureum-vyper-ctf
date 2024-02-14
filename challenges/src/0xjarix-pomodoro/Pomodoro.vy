# @version 0.3.9

# Interface for the PomodoroNFT contract
interface PomodoroNFT:
    def ownerOf(_tokenId: uint256) -> address: view

# Struct to track work session details
struct Session:
    lastPause: uint256  # Time the session was last paused
    accumulatedTime: uint256  # Total time accumulated towards the next reward
    ongoing: bool # True if Session has started
    isPaused: bool # True if session is paused, False otherwise

nftAddress: public(address)
sessionDuration: public(uint256)  # Required duration for a reward
remainingTime: public(uint256) # Time of work that hasn't been rewarded yet because < 25 min when claimReward() was called
# Mapping from user address to their work session details
sessions: public(HashMap[address, Session])

@external
def __init__(_nftAddress: address):
    self.nftAddress = _nftAddress
    self.sessionDuration = 25 * 60  # 25 minutes, in seconds
    self.remainingTime = 0

@external
def startWorkSession(_tokenId: uint256):
    # Verify NFT ownership
    assert PomodoroNFT(self.nftAddress).ownerOf(_tokenId) == msg.sender

    # Initialize or reset the work session
    self.sessions[msg.sender] = Session({
        lastPause: block.timestamp,
        accumulatedTime: self.remainingTime,
        ongoing: True,
        isPaused: False
    })

@external
def pauseWorkSession(_tokenId: uint256):
    # Verify NFT ownership and that a session is active
    assert PomodoroNFT(self.nftAddress).ownerOf(_tokenId) == msg.sender
    session: Session = self.sessions[msg.sender]
    assert session.ongoing and not session.isPaused  # Ensure session is ongoing

    # Calculate and update accumulated time
    session.accumulatedTime += block.timestamp - session.lastPause
    session.isPaused = True
    self.sessions[msg.sender] = session

@external
def unpauseWorkSession(_tokenId: uint256):
    # Verify NFT ownership and that a session is paused
    assert PomodoroNFT(self.nftAddress).ownerOf(_tokenId) == msg.sender
    session: Session = self.sessions[msg.sender]
    assert session.isPaused # Ensure session is paused

    # Reset lastPause timestamp to now, keep accumulated time
    session.lastPause = block.timestamp
    session.isPaused = False
    self.sessions[msg.sender] = session

@external
@nonreentrant('')
def claimReward(_tokenId: uint256):
    # Verify NFT ownership
    assert PomodoroNFT(self.nftAddress).ownerOf(_tokenId) == msg.sender
    session: Session = self.sessions[msg.sender]

    # Ensure session is not currently paused
    assert not session.isPaused and session.ongoing

    # Calculate total session time including any previous accumulations
    totalSessionTime: uint256 = session.accumulatedTime
    totalSessionTime += block.timestamp - session.lastPause

    # Verify enough time has passed for a reward
    assert totalSessionTime >= self.sessionDuration

    # Calculate how many rewards are due
    rewardsDue: uint256 = totalSessionTime / self.sessionDuration

    # send rewards
    send(msg.sender, rewardsDue * (10 ** 12))

    # Reset or adjust session details based on remaining time
    self.remainingTime = totalSessionTime % self.sessionDuration
    self.sessions[msg.sender].ongoing = False