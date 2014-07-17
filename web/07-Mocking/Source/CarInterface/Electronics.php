<?php
/**
 * Created by PhpStorm.
 * User: david
 * Date: 15/07/14
 * Time: 17:42
 */

require_once 'Lights.php';

class Electronics {

    function turnOn(Lights $lights) {}
    function accelerate(){}
    function pushBrakes($brakingPower){}
}

class SpyingElectronics extends Electronics {
    private $brakingPower;

    function pushBrakes($brakingPower) {
        $this->brakingPower = $brakingPower;
    }

    function getBrakingPower() {
        return $this->brakingPower;
    }
}