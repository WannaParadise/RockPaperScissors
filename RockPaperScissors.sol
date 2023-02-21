// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RockPaperScissors {
    uint8 public playerMove;
    uint8 public botMove;
    address public playerAddress;
    bool public gameFinished;
    uint256 private nonce = 0;

    function submitMove(uint8 move) public {
        require(move >= 1 && move <= 3, "Invalid move");

        playerMove = move;
        playerAddress = msg.sender;
        gameFinished = false;
    }

    function botMove1() public {
        require(playerAddress != address(0), "No move submitted by player");

        nonce++;
        uint8 randomNumber = uint8(uint256(keccak256(abi.encodePacked(nonce, block.timestamp, block.difficulty, block.coinbase, block.number, block.gaslimit))) % 3 + 1);
        botMove = randomNumber;
        gameFinished = true;
    }

    function getWinner() public view returns (string memory) {
        require(gameFinished, "Game not finished");

        if (playerMove == botMove) {
            return "It's a tie!";
        } else if ((playerMove == 1 && botMove == 3) || (playerMove == 2 && botMove == 1) || (playerMove == 3 && botMove == 2)) {
            return "Player wins!";
        } else {
            return "Bot wins!";
        }
    }
}