# @version 0.3.10

"""

Example:

"I went to the cafe to get some c0ffee" X2

0 170 0 52428 0 15658734 16777215 

Problem:

"In the cozy cafe, patrons gathered to savor the rich c0ffee aroma wafting through the air. 
The menu boasted many delicious f00d options, from hearty breakfasts to savory lunches. 
Among the favorites were succulent beef dishes that satisfied even the most discerning palates. 
For those seeking lighter options, there was the popular decaf c0ffee, allowing patrons to unwind without the caffeine jolt. 
As the evening approached, some customers decided to call it an evening and went to bed." X2

? ? ? ? ? ? ?

"""

numbers: constant(uint256[7]) = [0, 77194726158210796949047323339125271902179989777093709359638389338608753093290, 84914198774031876643952055673037799092397988754803080295602228272469628402619, 92633671389852956338856788006950326282615987732512451231566067206330503711948, 100353144005674036033761520340862853472833986710221822167529906140191379021277, 108072616621495115728666252674775380663051985687931193103493745074052254330606, 115792089237316195423570985008687907853269984665640564039457584007913129639935]

vypers: DynArray[String[31], 32]

answerSlots: uint256[7]

@view
@internal
def added() -> uint256:
    return (self.answerSlots[0] + self.answerSlots[1] + self.answerSlots[2] + self.answerSlots[3] + self.answerSlots[4] + self.answerSlots[5] + self.answerSlots[6])

@view
@internal
def multiplied() -> uint256:
    return self.answerSlots[1] * self.answerSlots[2] * self.answerSlots[3] * self.answerSlots[4] * self.answerSlots[5] * self.answerSlots[6]

@internal
def generate(numChars: uint256):
    tempA: String[31] = self.vypers[numChars % 32]
    tempB: String[32] = concat(tempA, "z")


@external
def modify(numChars: uint256, slot: uint256):
    a: uint256 = numbers[slot % 7]
    self.generate(numChars)
    self.answerSlots[slot % 7] = a


@external
def getSlot(number: uint256) -> uint256:
    return self.answerSlots[number]


@internal
@view
def calculateHash() -> bytes32:
    a: uint256 = self.added()
    b: uint256 = self.multiplied()
    aBytes: bytes32 = convert(a, bytes32)
    bBytes: bytes32 = convert(b, bytes32)
    aHash: bytes32 = keccak256(aBytes)
    bHash: bytes32 = keccak256(bBytes)
    combined: bytes32 = keccak256(concat(aBytes, bBytes))
    return combined


@external
@view
def isSolved() -> bool: 
    return self.calculateHash() == 0x44151f2d1d75e470fe53e66a10133905bb427c52162de88f778835705f0c5b43

@external
def __init__():
    # vyper repeated up to index 31
    self.vypers.append("")
    self.vypers.append("v")
    self.vypers.append("vy")
    self.vypers.append("vyp")
    self.vypers.append("vype")
    self.vypers.append("vyper")
    self.vypers.append("vyperv")
    self.vypers.append("vypervy")
    self.vypers.append("vypervyp")
    self.vypers.append("vypervype")
    self.vypers.append("vypervyper")
    self.vypers.append("vypervyperv")
    self.vypers.append("vypervypervy")
    self.vypers.append("vypervypervyp")
    self.vypers.append("vypervypervype")
    self.vypers.append("vypervypervyper")
    self.vypers.append("vypervypervyperv")
    self.vypers.append("vypervypervypervy")
    self.vypers.append("vypervypervypervyp")
    self.vypers.append("vypervypervypervype")
    self.vypers.append("vypervypervypervyper")
    self.vypers.append("vypervypervypervyperv")
    self.vypers.append("vypervypervypervypervy")
    self.vypers.append("vypervypervypervypervyp")
    self.vypers.append("vypervypervypervypervype")
    self.vypers.append("vypervypervypervypervyper")
    self.vypers.append("vypervypervypervypervyperv")
    self.vypers.append("vypervypervypervypervypervy")
    self.vypers.append("vypervypervypervypervypervyp")
    self.vypers.append("vypervypervypervypervypervype")
    self.vypers.append("vypervypervypervypervypervyper")
    self.vypers.append("vypervypervypervypervypervyperv")
