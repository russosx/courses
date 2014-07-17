<?php
/**
 * Created by PhpStorm.
 * User: david
 * Date: 16/07/14
 * Time: 21:47
 */

require_once dirname(__FILE__) . '/../Classes/Nettuts.php';

class NettutsTest extends PHPUnit_Framework_TestCase {

    protected $object;

    protected function setUp() {
        $this->object = new Nettuts;
    }

    protected function tearDown() {

    }

    function testDummyPassingTest() {
        $this->assertTrue(false);
    }
}
 