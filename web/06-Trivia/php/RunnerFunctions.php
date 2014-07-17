<?php
/**
 * Created by PhpStorm.
 * User: david
 * Date: 17/07/14
 * Time: 20:29
 */

include_once __DIR__ . '/Game.php';

/**
 * @param $minAnswerId
 * @param $maxAnswerId
 * @param $wrongAnswerId
 * @return bool
 */
function isCurrentAnswerCorrect()
{
    $minAnswerId = 0;
    $maxAnswerId = 9;
    $wrongAnswerId = 7;
    return rand($minAnswerId, $maxAnswerId) != $wrongAnswerId;
}

function run() {
    $notAWinner = null;

    $aGame = new Game();

    $aGame->add("Chet");
    $aGame->add("Pat");
    $aGame->add("Sue");

    do {
        $dice = rand(0, 5) + 1;
        $aGame->roll($dice);

        if (isCurrentAnswerCorrect()) {
            $notAWinner = $aGame->wasCorrectlyAnswered();
        } else {
            $notAWinner = $aGame->wrongAnswer();
        }

    } while ($notAWinner);
}
