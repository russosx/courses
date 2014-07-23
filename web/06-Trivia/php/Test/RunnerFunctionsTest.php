<?php
/**
 * Created by PhpStorm.
 * User: russ
 * Date: 22/07/14
 * Time: 18:41
 */

require_once __DIR__ . '/../RunnerFunctions.php';

class RunnerFunctionsTest extends PHPUnit_Framework_TestCase {

    function testItCanFindCorrectAnswer() {
        $this->assertAnswersAreCorrectFor($this->getCorrectAnswerIDs());
    }

    function testItCanFindWrongAnswer() {
        $this->assertFalse(isCurrentAnswerCorrect(WRONG_ANSWER_ID, WRONG_ANSWER_ID));
    }

    function testItCanTellIfThereIsNoWinnerWhenACorrectAnswerIsProvided() {
        $this->assertTrue(getNotWinner($this->aFakeGame(), $this->aCorrectAnswer()));
    }

    function testItCanTellIfThereIsNoWinnerWhenAWrongAnswerIsProvided() {
        $this->assertFalse(getNotWinner($this->aFakeGame(), $this->aWrongAnswer()));
    }

    private function assertAnswersAreCorrectFor($correctAnswerIDs) {
        foreach ($correctAnswerIDs as $id) {
            $this->assertTrue(isCurrentAnswerCorrect($id, $id));
        }
    }

    private function getCorrectAnswerIDs() {
        return array_diff(range(MIN_ANSWER_ID, MAX_ANSWER_ID), [WRONG_ANSWER_ID]);
    }

    /**
     * @return FakeGame
     */
    protected function aFakeGame()
    {
        $aGame = new FakeGame();
        return $aGame;
    }

    /**
     * @return bool
     */
    protected function aWrongAnswer()
    {
        return false;
    }

    /**
     * @return bool
     */
    protected function aCorrectAnswer()
    {
        return true;
    }

}

class FakeGame {

    function wasCorrectlyAnswered() {
        return true;
    }

    function wrongAnswer() {
        return false;
    }
}