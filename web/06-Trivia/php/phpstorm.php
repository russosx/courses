<?php
/**
 * Created by PhpStorm.
 * User: david
 * Date: 15/07/14
 * Time: 15:35
 */

class SomeClass {

    protected $playerHeader = "Player name: ";

    function printAPairOfPlayers() {
        echo "Players are:";

        $playerHeadersString = $this->playerHeader;
        echo $playerHeadersString . $this->getRandomPlayerName();
        echo $playerHeadersString . $this->getRandomPlayerName();
    }

    function printOnePlayer() {
        echo $this->playerHeader . $this->getRandomPlayerName();
    }

    function getRandomPlayerName() {
        // Some logic to find player names //
        $playerName = 'Russ';
        return $playerName;
    }

}