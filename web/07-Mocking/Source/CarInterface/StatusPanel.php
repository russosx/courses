<?php
/**
 * Created by PhpStorm.
 * User: david
 * Date: 16/07/14
 * Time: 19:56
 */

class StatusPanel {

}

class SpyingStatusPanel extends StatusPanel {

    private $speedWasRequested = false;
    private $currentSpeed = 1;

    function getSpeed() {
        if ($this->speedWasRequested)
            $this->currentSpeed = 0;
        $this->speedWasRequested = true;
        return $this->currentSpeed;
    }

    function speedWasRequested() {
        return $this->speedWasRequested;
    }

    function spyOnSpeed() {
        return $this->currentSpeed;
    }

}