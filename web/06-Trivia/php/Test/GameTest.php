<?php
/**
 * Created by PhpStorm.
 * User: russ
 * Date: 22/07/14
 * Time: 20:42
 */

require_once __DIR__ . '/../Game.php';

class GameTest extends PHPUnit_Framework_TestCase {

    protected $game;

    function setUp() {
        $this->game = new Game();
    }

    function tearDown() {
        unset($this->game);
    }

    function testAGameWithNotEnoughPlayersIsNotPlayable() {
        $this->assertFalse($this->game->isPlayable());
        $this->addJustNotEnoughPlayers($game);
        $this->assertFalse($this->game->isPlayable());
    }

    function testAfterAddingTwoPlayersToANewGameItIsPlayable() {
        $this->addEnoughPlayers();
        $this->assertTrue($this->game->isPlayable());
    }

    function testItCanAddANewPlayer() {
        $this->assertEquals(0, count($this->game->players));
        $this->game->add('A player');
        $this->assertEquals(1, count($this->game->players));
        $this->assertDefaultPlayerParametersAreSetFor(1);
    }

    function testWhenAPlayerEntersAWrongAnswerItIsSentToThePenaltyBox() {
        $this->game->add('A player');
        $this->game->currentPlayer = 0;
        $this->game->wrongAnswer();
        $this->assertTrue($this->game->inPenaltyBox[0]);
        $this->assertEquals(0, $this->game->currentPlayer);
    }

    function testCurrentPlayerIsNotResetAfterWrongAnswerIfOtherPlayersDidNotYetPlay() {
        $this->addManyPlayers(2);
        $this->game->currentPlayer = 0;
        $this->game->wrongAnswer();
        $this->assertEquals(1, $this->game->currentPlayer);
    }

    function testTestPlayerWinsWithTheCorrectNumberOfCoins() {
        $this->game->currentPlayer = 0;
        $this->game->purses[0] = Game::$numberOfCoinsToWin;
        $this->assertFalse($this->game->didPlayerNotWin());
    }

    protected function assertDefaultPlayerParametersAreSetFor($playerId) {
        $this->assertEquals(0, $this->game->places[$playerId]);
        $this->assertEquals(0, $this->game->purses[$playerId]);
        $this->assertFalse($this->game->inPenaltyBox[$playerId]);
    }

    private function addEnoughPlayers() {
        $this->addManyPlayers(Game::$minimumNumberOfPlayers);
    }

    private function addJustNotEnoughPlayers() {
        $this->addManyPlayers(Game::$minimumNumberOfPlayers - 1);
    }

    private function addManyPlayers($numberOfPlayers) {
        for ($i = 0; $i < $numberOfPlayers; $i++) {
            $this->game->add('A Player');
        }
    }
}
 