<?php
/**
 * Created by PhpStorm.
 * User: david
 * Date: 15/07/14
 * Time: 17:39
 */

class CarController {

    function getReadyToGo(Engine $engine, Gearbox $gearbox, Electronics $electronics, Lights $lights) {
        $engine->start();
        $gearbox->shift('N');
        $electronics->turnOn($lights);
        return true;
    }

    function goForward(Electronics $electronics, StatusPanel $statusPanel = null) {
        $statusPanel = $statusPanel ? : new StatusPanel();
        if ($statusPanel->engineIsRunning() && $statusPanel->thereIsEnoughFuel())
            $electronics->accelerate();
    }

    function stop($brakingPower, Electronics $electronics, StatusPanel $statusPanel = null) {
        $statusPanel = $statusPanel ? : new StatusPanel();
        $electronics->pushBrakes($brakingPower);
        if ($statusPanel->getSpeed())
            $this->stop($brakingPower, $electronics, $statusPanel);
    }
} 