# Secureum Vyper CTF

![Secureum-Vyper-CTF-header](img/Secureum-Vyper-CTF-header.png)

<details>
<summary><b>Week 1: Challenge design</b></summary>

If you are reading this, congratulations! You have made it to the top 16 of RACE-26 and are officially participating in the Secureum Vyper CTF!

## What is this about?

The: Secureum Vyper CTF is a collaborative competition where you will design and submit an original CTF challenge written in Vyper and deployed on the Holesky testnet.

## Week 1: Challenge design

In this first week, you will be designing and submitting a CTF challenge completely written in Vyper and deployed on the Holesky testnet (use the following RPC endpoint: `https://ethereum-holesky.publicnode.com/`).

### Frameworks

To do so, you can use any framework or tool you want, such as:

- [Foundry](https://book.getfoundry.sh/), through [pcaversaccio](https://github.com/pcaversaccio)'s [`VyperDeployer.sol`](https://github.com/pcaversaccio/snekmate/blob/main/lib/utils/VyperDeployer.sol)
- [Brownie](https://eth-brownie.readthedocs.io/en/stable/)
- [ApeWorkX](https://docs.apeworx.io/), through the [`ape-vyper`](https://github.com/ApeWorX/ape-vyper) plugin
- [Hardhat](https://hardhat.org/docs), through the [`hardhat-vyper`](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-vyper) plugin
- [Remix IDE](https://remix.ethereum.org/), through the `vyper-plugin` (see [the plugins list](https://remix-ide.readthedocs.io/en/latest/plugin_list.html))

### `vyper` compiler

If it's your first time working with Vyper, or generally any kind of `python`-based project, you might want to install the `vyper` compiler and its dependencies in a virtual environment. To do so, you can follow the instructions in the [Vyper documentation](https://docs.vyperlang.org/en/latest/installing-vyper.html#creating-a-virtual-environment).

### Submission

To submit your challenge, you will need to create a private repository in your GitHub account and invite [luksgrin](https://github.com/luksgrin) as collaborator. The repository should contain:

- A `README.md` file with a description of the challenge (title, story...), the solution, and the contract's address on the Holesky testnet (there's no need to verify the source code, but feel free to do so if you want to)
- The source code of your challenge in a `src/` directory

It is recommended that you use a framework that allows you to write tests for your challenge, but it is not mandatory. If you do write tests, you can include them in a `test/` directory.

For the sake of consistency, all challenges must implement the `IVyperSecureumCTF` interface, which is defined as follows:

```python
@external
def isSolved() -> bool:
    """
    Returns whether the challenge has been solved or not.
    """
    pass
```

### Evaluation

The challenge will be considered valid if it is solvable by (at least) the solution you provide. If deemed solvable, the challenge will be added to the roster of challenges for the second week of the competition.

## Example

To give you an idea of a valid submission, head over to the [`example`](example) directory.

</details>

## Week 2: Challenge solving

In this second week, you will be submitting solutions and write-ups of your peers' Vyper CTF challenges, and will accumulate points by doing so.

## Scoring

The scoring system is as follows:

- 1 point for submitting a valid solution, i.e. a smart contract that solves the challenge and makes `isSolved()` return `True`
- 3 points for submitting a valid solution **that differs** from the one provided by the challenge's author (which would imply that the challenge had multiple solutions)

### Prizes

- The top 3 leaderboard at the end of the competition will receive a commemorative POAP
- The best write-up of the competition will receive a commemorative POAP _(the more challenges you solve, the more chances you have to win!)_
- The prize pot of the competition will be 200 Holesky ETH shared proportionally among participants depending on the number of points obtained

## Post-competition

After the competition, the challenges, writeups and solutions will be made public for everyone to enjoy and learn from. All participants will be given credit for their challenges and writeups.

## Challenges

### 1. [0xjarix - Pomodoro](./challenges/src/0xjarix-pomodoro/)

<details>
<summary><b>Challenge description</b></summary>

There's a new Work-To-Earn in town.

Get your **PomodoroNFT** so you're eligible for rewards on the Pomodoro DApp.

You might have heard of the "_Pomodoro Technique_" if you're all about being productive in your work, nonetheless here's a quick explanation:

Usually people work for 5 hours straight, lose efficiency as time goes on due to lack of focus, and get 1 hour of rest afterwards. The Pomodoro technique consists of highly efficient working shifts of 25 minutes followed by 5 minutes of rest as people find it difficult to focus for more than 25 minutes. The Pomodoro DApp incentivizes the use of the Pomodoro technique by awarding users with some ETH provided they own a PomodoroNFT. For every 25 minute of work, the user receives 0.01 ETH.

The NFT costs `0.1 ether`, and the reward is `0.01 ether`.

For flexibility purposes, the length of the pause is not fixed, although it is recommended that users spend exactly 5 minutes. The user can pause whenever they want for emergency purposes.

Could you drain the Pomodoro contract's funds?

_Access the test script [here](./challenges/test/0xjarix-pomodoro/PomodoroCTFTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/0xjarix-pomodoro/PomodoroCTFTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.9`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 2. [sakarkc2122 - DEX](./challenges/src/sakarkc2122-dex/)

<details>
<summary><b>Challenge description</b></summary>

There is a DEX contract written using the Vyper programming language. The contract `dex.vy` creates a dex for swapping two tokens. The contract `Tokens` creates the ERC20 token. For this CTF, when you deploy and get the contract instance:

1. You get 100 T1 and 100 T2.
2. The Dex contract gets 1000 T1 and 1000 T2. 

Could you steal all T1 and T2 tokens from the Dex contract?

_Access the test script [here](./challenges/test/sakarkc2122-dex/SakarDEXCTFTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/sakarkc2122-dex/SakarDEXCTFTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.10`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>


### 3. [neumoxx - Succession CTF](./challenges/src/neumoxx-succession/)

<details>
<summary><b>Challenge description</b></summary>

```
-----------------------------------------=----==----------------------------------------------
---------------------------------==+=+*##%%%%%**%%%#*=----------------------------------------
---------------------------------=%@@@@@@@@@@@@@@@@@@@@@%++==---------------------------------
--------------------------------=*%@@@@@@@@@@@@@@@@@@@@@@@@@%#*#==----=-----------------------
------------------------------=-+@@@@@@%%@@@@@@@@@@%%%%@@@@@@@@@@@@@#+------------------------
-------------------------------=*@@%%%%%@@%@@@@@%%%@@%@%%@@@@@@@@@@@@%#=-=-----------=-=------
----------------------------===*%%##%%%%@%@@@@@@@@@@@@@%%%@@@@@@@@@@@@@%+==-------------------
-----------------------------=+#%%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*-=-------==---------
---------------------------==#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#---=---------------
---------------------------=+%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%#=---=----==-------
------------------------==**%@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@@@@@@@@@@@@@@@@@#----=-=-====-----=
-------------------------=+#%@@@@@@@@@@@@@@@@@@@%%@%%%%%%%@%@@@@@@@@@@@@@@%%------==------=--=
-------------------------+%%%%%@@@@@@@@@@@@%@@%%%@%%%%%%%@@@@%%@@@@@@@@@@%%%%%%%%%%%%%##**++==
-----------------------=-*%%@@@%%%%%%@@@@@@@@@@@@@%%%%%%%%@@%@@%%@@@@@@%@@%##%%%%%%%%%%%%%%%%%
-----------------------==#%%%@@@@@%%@@@@@@@%%%%%%%%%#####%@@@@@#%%%%##%%%%%##%%%%%%%%%%%%%%%%%
------------------------=*%%%@@@@@%@@@%%%%#%@@@@@%%%%%%%%%@@@@@%%%####+**#%%#%%%%%%%%%%%%%%%%%
-------------------------+@@%%%%%%%##%@@@@@@#***#%%%%%%%%@%%%%%#@@@%%*++++*#%#%%%%%%%%%%%%%%%%
-------------------------#%**#%#*+#%=++#***+****+*####%%%%%%#*#%*+++=++++=+*##%###############
------------------------+**#**+===*#+----==+***##+****#%%%%%##*****-+=:-=+#+*##########%%#%%%%
-------------------------=***=---=*%*=-:--:::-=+*****%%%%%%%%#%##*++-:--:-*%*######%%%%%%%%%%%
--------------------------+::::--+%@%*+---=++==-=--==*#%%%%#%###*++-:-==-:=-*##%%%%%%%%%%%%%%%
--------------------------=*****+%@%%#*++=++**#%%%%@%%%%%#****++==+-::--++--###%%%%%%%%%%%%%%%
--------------------------+#****%@@%%###*****##%%%%%%%%#%#***++=++=+::--#+#+##############%%%%
--------------------------*##**#%@@%%%##***#%%@%%%%###*#####***#*+==:+##==**###########*****##
--------------------------+#**#%@@@@%%@%%+#%%@@@%#****#%%####%%%#**-####*#=+############******
--------------------------=++*%####*****##%#%%%%%###%%%##%%#%%%%##=*%%%%*--=###############***
---------------------------**%#+*++=:::=-=@%*#%#%%%%%%%%%%#%%%%%#*@%%%#+--++##################
----------------------=-=-=##%%%*+=*#%@@@@@@%**#%############%%#*#*##*=--=*###****############
-------------=++*=-=-------#%@@@%%%%@@@@@@@@@@@+**##%%#*+*####*+%+-:--+-.:*************#######
----------#@@@@@@@@@@@@@@@@@@@@@@@+=+++*#%%%%@@@@*#%%%##*+***+=%#---=*=...:+**************####
--------=@@@@@@@@@@@@@@@@@%@@@@@@@@+-++++==--=*%%%%%####***+=#%#---+*+...:::::+****+==++++==-:
------:@@@@@@@@@@@@%#@@@@@%@@@@@@@@%+*#**+++++++*%%##***++=+%%#--=*+=::::::::::::-::::::::::::
-----+@@@%*##@@@@%@%%%@@@@@#@@@%%%%#*+**+++****####*++=+=+#%%+-+=*@@::::::::::-:::::::::::::--
----%@@@@%#+-=**%@%%++%@%%%*%@@%%%#=.-*%%%%@@@@@@%%*=+*++%%#===+*%%::::::::----::::::::::::---
---@@@%%%#*=-::*#%%%*:#%%##-#@%#**+.:.:.:*%@@%%%@@%+=#**##===*+*@+:::::::-------::::::::::----
-=@@%%%%#+===:--**++-.-*###:#%%#-:-+*++:...:-*%@%%%+#*++==+*++%@+:-::-:---------::::::::------
%@@%%%*+++==--:=+++=::=#*+=.=%%#=-==+*#*##=:...:+*+++==+*%@@@@@=:--:---:-------.::::::--------
@@%%+*+*+======+=+=--:-***=::-=====++***#*###%#=...-##@@@@@@@@%:----::------:.::::::----------
%#+=.##*++=====#---==-==*=======++++++*+++***++=--#--@@@@@@@@%:-----------:.::-:::::-----::--:
@#--=+++++=-=++============-:----==========--:::*#@@+=@@@@@@@-------------:::-:::---=-:::..:::
%#*+--::==+++++++======--------::::::::#+:::::+%@@@@@:%@@@@@#-------------:::::::---:.....::..
#**++*--:.===+=====-----------::::::-:=#+=:.=*=+@@@@@@.@@@@@:---------------:::::-:......:::..
#**+++++-::::----------------:::::::::##:.-===+++=*@@@:*@@@----------------::::--:......::....
*+++++===--::-:===-=-------::::::-:::.#=..=+=-::--...@@.@@*:---------:-----::::--:.....:::...:
*+==---------::.:-==----------:::-::..#....::::---:....:@@:---------------.:::---......:...:-:
**++++==------==:.:=-------------:::..*...-:-::::::..--+::---------------.::::-:::....::::::--
**+++==------===---..-----------:::...+.:-:::..::::-==@@#---------------:::::-:::....::::::::-
**++=-=-=---=====---:.:--------:::...-=:+:::...:::::@@@@---------------:::::---::....::...::--
+++=:.=------=--------:.------:::...=:--.:....::::*@@@@-:--------------:::-:--::.........::---
=-:..==-------=--------:.:::::::...==:-+-=:::::-%#@@@@#:--------------:::::-::::.......:::--:-
:::.------------=--=----:..::::...=+-:=:-:-::=@@@@@@@@---------------::::-----:::.....::::-::-
```

Henry senior has setup a meeting with his three children: Marion, Anna and Henry junior. About to retire after a very successful business activity throughout his life, he has decided to retire and divide his 30_000 shares of the company giving his kids 10_000 shares each. For this, 
they just have to sign the document and receive their piece of the pie.

But you (Henry Junior) have other plans. You wants everything. Will you be able to get the full 30_000 shares of the company?

_Access the test script [here](./challenges/test/neumoxx-succession/SuccessionCTFTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/neumoxx-succession/SuccessionCTFTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.0`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 4. [eloi010 - Vexillology Challenge](./challenges/src/eloi010-vexillology/)

<details>
<summary><b>Challenge description</b></summary>

In the Vexillology Challenge, players strive to capture the flag of a specific country, showcasing their expertise in Vyper and tactical gameplay. Can you capture the flag of the country?

_Access the test script [here](./challenges/test/eloi010-vexillology/VexillologyTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/eloi010-vexillology/VexillologyTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.10`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 5. [qpzm - CTF](./challenges/src/qzpm/)

<details>
<summary><b>Challenge description</b></summary>

...

_Access the test script [here](./challenges/test/qzpm/CTFTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/qzpm/CTFTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.0`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 6. [federicobianucci - SNAKE Presale](./challenges/src/federicobianucci-SNAKE-presale/)

<details>
<summary><b>Challenge description</b></summary>

SNAKE the vyper king is born!

Buy `$SNAKE` tokens, the new `$DOGE` written in vyper! You can also refer your friends paying gas for them and get 5% of their purchase!

100 ETH has been deposited in this contract. If there was only a way to get it out before the presale ends...

_Access the test script [here](./challenges/test/federicobianucci-SNAKE-presale/SNAKEPresaleTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/federicobianucci-SNAKE-presale/SNAKEPresaleTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.7`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 7. [Zac369 - ByteBrew](./challenges/src/zac369-byte-brew/)

<details>
<summary><b>Challenge description</b></summary>

"_In the cozy cafe, patrons gathered to savor the rich c0ffee aroma wafting through the air. 
The menu boasted many delicious f00d options, from hearty breakfasts to savory lunches. 
Among the favorites were succulent beef dishes that satisfied even the most discerning palates. 
For those seeking lighter options, there was the popular decaf c0ffee, allowing patrons to unwind without the caffeine jolt. 
As the evening approached, some customers decided to call it an evening and went to bed..._" X2

_Access the test script [here](./challenges/test/zac369-byte-brew/ZacByteBrewTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/zac369-byte-brew/ZacByteBrewTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.10`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 8. [rotcivegaf - ArgentineBallot](./challenges/src/rotcivegaf-argentineballot/)

<details>
<summary><b>Challenge description</b></summary>

...

_Access the test script [here](./challenges/test/rotcivegaf-argentineballot/BallotTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/rotcivegaf-argentineballot/BallotTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.7`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 9. [m4ttm - CrowdFund](./challenges/src/m4ttm-crowdfund/)

<details>
<summary><b>Challenge description</b></summary>

Crowdfund is a token which can be bought and sold at a fixed price directly on it's own contract.. But is it flawed?

_Access the test script [here](./challenges/test/m4ttm-crowdfund/CrowdFundTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/m4ttm-crowdfund/CrowdFundTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.2.16`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>

### 10. [romeroadrian - Vaulty](./challenges/src/romeroadrian-vaulty/)

<details>
<summary><b>Challenge description</b></summary>

A new Vyper Vault has been just deployed and Alice is about to ape into it with 15 ETH. Your snake sense has been triggered, bite fast and steal everything from the vault.

_Access the test script [here](./challenges/test/romeroadrian-vaulty/VaultyTest.t.sol). Remember, to run this script you must execute:_

```bash 
forge test --match-path test/romeroadrian-vaulty/VaultyTest.t.sol
```

_**Note**: This challenge requires vyper compiler version `0.3.10`. Make sure you have the appropriate virtual environment set up for compilation!_

</details>
