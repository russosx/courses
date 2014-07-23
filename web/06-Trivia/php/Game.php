<?php

function echoLine($string) {
    echo $string . "\n";
}

class Game
{
    static $minimumNumberOfPlayers = 2;
    static $numberOfCoinsToWin = 6;

    var $players;
    var $places;
    var $purses;
    var $inPenaltyBox;
    
    var $popQuestions;
    var $scienceQuestions;
    var $sportsQuestions;
    var $rockQuestions;
    
    var $currentPlayer = 0;
    var $isGettingOutOfPenaltyBox;

    function __construct() {
        
        $this->players = array();
        $this->places = array(0);
        $this->purses = array(0);
        $this->inPenaltyBox = array(0);
        
        $this->popQuestions = array();
        $this->scienceQuestions = array();
        $this->sportsQuestions = array();
        $this->rockQuestions = array();

        $categorySize = 50;
        for ($i = 0; $i < $categorySize; $i++) {
            array_push($this->popQuestions, "Pop Question " . $i);
            array_push($this->scienceQuestions, "Science Question " . $i);
            array_push($this->sportsQuestions, "Sports Question " . $i);
            array_push($this->rockQuestions, "Rock Question " . $i);
        }
    }
    
    function isPlayable() {
    	$minimumNumberOfPlayers = 2;
        return ($this->howManyPlayers() >= self::$minimumNumberOfPlayers);
    }
    
    function add($playerName) {
        array_push($this->players, $playerName);
        $this->setDefaultPlayerParametersFor($this->howManyPlayers());
        
        echoLine($playerName . " was added");
        echoLine("They are player number " . count($this->players));
        return true;
    }
    
    function howManyPlayers() {
        return count($this->players);
    }
    
    function roll($roll) {
        echoLine($this->players[$this->currentPlayer] . " is the current player");
        echoLine("They have rolled a " . $roll);
        
		$boardSize = 12;
        if ($this->inPenaltyBox[$this->currentPlayer]) {
            if ($this->isOdd($roll)) {
                $this->isGettingOutOfPenaltyBox = true;
                
                echoLine($this->players[$this->currentPlayer] . " is getting out of the penalty box");
                $this->places[$this->currentPlayer] = $this->places[$this->currentPlayer] + $roll;
                if ($this->playerShouldStartANewLap())
                	$this->places[$this->currentPlayer] = $this->places[$this->currentPlayer] - $boardSize;
                
                echoLine($this->players[$this->currentPlayer] . "'s new location is " . $this->places[$this->currentPlayer]);
                echoLine("The category is " . $this->currentCategory());
                $this->askQuestion();
            } else {
                echoLine($this->players[$this->currentPlayer] . " is not getting out of the penalty box");
                $this->isGettingOutOfPenaltyBox = false;
            }
        } else {
            
            $this->places[$this->currentPlayer] = $this->places[$this->currentPlayer] + $roll;
            if ($this->playerShouldStartANewLap())
            	$this->places[$this->currentPlayer] = $this->places[$this->currentPlayer] - $boardSize;
            
            echoLine($this->players[$this->currentPlayer] . "'s new location is " . $this->places[$this->currentPlayer]);
            echoLine("The category is " . $this->currentCategory());
            $this->askQuestion();
        }
    }
    
    function askQuestion() {
        if ($this->currentCategory() == "Pop") echoLine(array_shift($this->popQuestions));
        if ($this->currentCategory() == "Science") echoLine(array_shift($this->scienceQuestions));
        if ($this->currentCategory() == "Sports") echoLine(array_shift($this->sportsQuestions));
        if ($this->currentCategory() == "Rock") echoLine(array_shift($this->rockQuestions));
    }
    
    function currentCategory() {
    	$popCategory = "Pop";
	    $scienceCategory = "Science";
	    $sportCategory = "Sports";
	    $rockCategory = "Rock";
        if ($this->places[$this->currentPlayer] == 0) return $popCategory;
        if ($this->places[$this->currentPlayer] == 4) return $popCategory;
        if ($this->places[$this->currentPlayer] == 8) return $popCategory;
        if ($this->places[$this->currentPlayer] == 1) return $scienceCategory;
        if ($this->places[$this->currentPlayer] == 5) return $scienceCategory;
        if ($this->places[$this->currentPlayer] == 9) return $scienceCategory;
        if ($this->places[$this->currentPlayer] == 2) return $sportCategory;
        if ($this->places[$this->currentPlayer] == 6) return $sportCategory;
        if ($this->places[$this->currentPlayer] == 10) return $sportCategory;
        return $rockCategory;
    }
    
    function wasCorrectlyAnswered() {
        if ($this->inPenaltyBox[$this->currentPlayer]) {
            if ($this->isGettingOutOfPenaltyBox) {
                echoLine("Answer was correct!!!!");
                $this->purses[$this->currentPlayer]++;
                echoLine($this->players[$this->currentPlayer] . " now has " . $this->purses[$this->currentPlayer] . " Gold Coins.");
                
                $winner = !$this->didPlayerNotWin();
                $this->currentPlayer++;
                if ($this->shouldResetCurrentPlayer()) $this->currentPlayer = 0;
                
                return $winner;
            } else {
                $this->currentPlayer++;
                if ($this->shouldResetCurrentPlayer()) $this->currentPlayer = 0;
                return true;
            }
        } else {
            
            echoLine("Answer was corrent!!!!");
            $this->purses[$this->currentPlayer]++;
            echoLine($this->players[$this->currentPlayer] . " now has " . $this->purses[$this->currentPlayer] . " Gold Coins.");
            
            $winner = !$this->didPlayerNotWin();
            $this->currentPlayer++;
            if ($this->shouldResetCurrentPlayer()) $this->currentPlayer = 0;
            
            return $winner;
        }
    }
    
    function wrongAnswer() {
        echoLine("Question was incorrectly answered");
        echoLine($this->players[$this->currentPlayer] . " was sent to the penalty box");
        $this->inPenaltyBox[$this->currentPlayer] = true;
        
        $this->currentPlayer++;
        if ($this->shouldResetCurrentPlayer()) $this->currentPlayer = 0;
        return true;
    }
    
    function didPlayerNotWin() {
        return !($this->purses[$this->currentPlayer] == self::$numberOfCoinsToWin);
    }

    protected function isOdd($roll)
    {
        return $roll % 2 != 0;
    }

    /**
     * @param $lastPlaceOnTheBoard
     * @return bool
     */
    protected function playerShouldStartANewLap()
    {
        $lastPlaceOnTheBoard = 11;
        return $this->places[$this->currentPlayer] > $lastPlaceOnTheBoard;
    }

    /**
     * @return bool
     */
    protected function shouldResetCurrentPlayer()
    {
        return $this->currentPlayer == count($this->players);
    }

    protected function setDefaultPlayerParametersFor($playerId)
    {
        $this->places[$playerId] = 0;
        $this->purses[$playerId] = 0;
        $this->inPenaltyBox[$playerId] = false;
    }
}
