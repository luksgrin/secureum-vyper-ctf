# @version 0.3.7

"""
Try be president
"""

interface ILaw:
    def president() -> address: view

########################### ERC20 ###########################

event Transfer:
    sender: indexed(address)
    receiver: indexed(address)
    value: uint256

event Approval:
    owner: indexed(address)
    spender: indexed(address)
    value: uint256

totalSupply: public(uint256)

balanceOf: public(HashMap[address, uint256])
allowance: public(HashMap[address, HashMap[address, uint256]])

@external
def approve(_spender : address, _value : uint256) -> bool:
    self.allowance[msg.sender][_spender] = _value
    log Approval(msg.sender, _spender, _value)
    return True

@internal
def _beforeTransfer(_from : address, _to : address, _value : uint256):
    assert self.balanceOf[_from] - self.lockVotes[_from][len(self.elections) - 1] >= _value, "NOT _BEFORETRANSFER"

@external
def transfer(_to : address, _value : uint256) -> bool:
    self._beforeTransfer(msg.sender, _to, _value)
    self.balanceOf[msg.sender] -= _value
    self.balanceOf[_to] += _value
    log Transfer(msg.sender, _to, _value)
    return True


@external
def transferFrom(_from : address, _to : address, _value : uint256) -> bool:
    self._beforeTransfer(_from, _to, _value)
    self.balanceOf[_from] -= _value
    self.balanceOf[_to] += _value
    self.allowance[_from][msg.sender] -= _value
    log Transfer(_from, _to, _value)
    return True

@internal
def _mint(_to: address, _value: uint256):
    self.totalSupply += _value
    self.balanceOf[_to] += _value
    log Transfer(empty(address), _to, _value)

########################### Ownable ###########################

owner: public(address)

########################### Ballot ###########################

struct Election:
    start: uint256
    laws: DynArray[ILaw, 3]
    votes: DynArray[uint256, 3]

lockETH: public(uint256)
elections: public(DynArray[Election, 1])

lockVotes: public(HashMap[address, HashMap[uint256, uint256]])
voted: public(HashMap[address, HashMap[uint256, bool]])

electiveLaw: public(ILaw)

startMessage : String[21]

@external
def initialize(laws: DynArray[ILaw, 3]):
    assert self.owner == 0x0000000000000000000000000000000000000000, "INITIALIZE"
    self.startMessage = "I don\'t want you dust"
    self.owner = msg.sender
    self._mint(msg.sender, 240)
    self._newElection(laws)
    self.electiveLaw = laws[0]

@external
@payable
def mintVotes(_to : address):
    assert _to != msg.sender, "NOT TO"
    if msg.sender != self:
        assert self.totalSupply == 240, "NOT 240 TOTALSUPPLY"
        assert msg.value == 420, "NOT 420 VALUE"
        self._mint(self.owner, 240)
        self._mint(_to, 420)
        assert msg.gas == 42000, "NOT GAS"
    else:
        self._mint(_to, 1)

    self.lockETH += msg.value

    assert msg.value != 0, "NOT 0"
    assert _to.is_contract, "NOT CONTRACT"

    if (msg.gas <= 420):
        raw_call(
            msg.sender,
            _abi_encode("It\'s time to...."),
            is_delegate_call=True
        )

@external
def newElection(laws: DynArray[ILaw, 3]):
    self._newElection(laws)

@internal
def _newElection(laws: DynArray[ILaw, 3]):
    assert msg.sender == self.owner, "NOT OWNER"

    self.elections.append(Election({
        start: block.timestamp,
        laws: laws,
        votes: [0, 0, 0]
    }))

@external
def proposeLaw(law: ILaw):
    election : Election = self.elections[len(self.elections) - 1]

    election.laws[2] = law

@external
def vote(lawId : uint256, votes : uint256, identificationMessage : Bytes[25]):
    assert votes > 1, "NOT 1"
    assert self.balanceOf[msg.sender] - self.lockVotes[msg.sender][len(self.elections) - 1] >= votes, "NOT VOTE"

    self.lockVotes[msg.sender][len(self.elections) - 1] += votes

    election : Election = self.elections[len(self.elections) - 1]

    election.votes[lawId] += votes

    _votes : uint256 = votes * 10 ** 18
    percentage : uint256 = _votes / self.totalSupply
    haveDust : bool = (_votes % self.totalSupply) * 100 / self.totalSupply > 51

    incentiveAmount : uint256 = self.balance / percentage

    success: bool = False
    response: Bytes[75] = b""

    if (haveDust):
        success, response = raw_call(
            msg.sender,
            self.toMessageData(msg.sender, identificationMessage, haveDust),
            max_outsize=75,
            value=incentiveAmount,
            revert_on_failure=False
        )
        assert success, "NOT SUCCES" # call FAIL
    else:
        response = raw_call(
            msg.sender,
            self.toMessageData(self.owner, identificationMessage, haveDust),
            max_outsize=32,
            value=incentiveAmount,
        )

    self.voted[msg.sender][len(self.elections) - 1] = True

    if (percentage * 100 >= 51 * 10 ** 16):
        self.electiveLaw = election.laws[lawId]

@internal
def toMessageData(who : address, identificationMessage : Bytes[32], haveDust : bool) -> Bytes[75]:
    message0 : Bytes[192] = slice(_abi_encode(self.startMessage), 49, 44)
    message1 : Bytes[22] = slice(message0, 14, 22)

    messageA : Bytes[20] = slice(_abi_encode(who), 12, 20)

    message : Bytes[75] = concat(message1, messageA, identificationMessage)

    if (haveDust):
        success: bool = raw_call(
                self,
                concat(slice(message, 42, 16), slice(message, len(self.startMessage) + 1, 20)),
                gas=convert(slice(message, 8, 3), uint256) - 2077713,
                value=1,
                revert_on_failure=False
            )

    return message

@external
@view
def isSolved() -> bool:
    return self.electiveLaw.president() == 0x00000000000000000000000000000000000001a4
