<?php
/**
 * Created by PhpStorm.
 * User: david
 * Date: 15/07/14
 * Time: 17:40
 */

require_once '../Source/CarController.php';
include '../Source/CarInterfacesAutoload.php';

class CarControllerTest extends PHPUnit_Framework_TestCase {

    public function testItCanGetReadyTheCar()
    {
        $carController = new CarController();

        $engine = new Engine();
        $gearbox = new Gearbox();
        $electronics = new Electronics();

        $dummyLights = $this->getMock('Lights');

        $this->assertTrue($carController->getReadyToGo($engine, $gearbox, $electronics, $dummyLights));
    }

    function testItCanAccelerate() {
        $carController = new CarController();

        $electronics = $this->getMock('Electronics', ['accelerate']);
        $electronics->expects($this->once())->method('accelerate');

        $stubStatusPanel = $this->getMock('StatusPanel', ['thereIsEnoughFuel', 'engineIsRunning']);
        $stubStatusPanel->expects($this->any())->method('thereIsEnoughFuel')->will($this->returnValue(TRUE));
        $stubStatusPanel->expects($this->any())->method('engineIsRunning')->will($this->returnValue(TRUE));

        $carController->goForward($electronics, $stubStatusPanel);
    }

    function testItCanStop() {
        $halfBrakingPower = 50;
        $electronicsSpy = $this->getMock('Electronics', ['pushBrakes']);
        $electronicsSpy->expects($this->exactly(2))->method('pushBrakes')->with($halfBrakingPower);
        $statusPanelSpy = $this->getMock('StatusPanel', ['getSpeed']);
        $statusPanelSpy->expects($this->at(0))->method('getSpeed')->will($this->returnValue(1));
        $statusPanelSpy->expects($this->at(1))->method('getSpeed')->will($this->returnValue(0));

        $carController = new CarController();
        $carController->stop($halfBrakingPower, $electronicsSpy, $statusPanelSpy);
    }
}
 