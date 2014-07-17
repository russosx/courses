<?php

require __DIR__ . '/../GameRunner.php';

class GoldenMasterTest extends PHPUnit_Framework_TestCase
{
    
    private $gmPath;
    private $times = 100;
 
    function setUp() {
        $this->gmPath = __DIR__ . '/gm.txt';
    }

    protected function generateOutput($seed) {
        ob_start();
        srand($seed);
        run();
        $output = ob_get_contents();
        ob_end_clean();
        return $output;
    }

    protected function generateMany($times, $fileName) {
        $first = true;
        while ($times) {
            if ($first) {
                file_put_contents($fileName, $this->generateOutput($times));
                $first = false;
            } else {
                file_put_contents($fileName, $this->generateOutput($times), FILE_APPEND);
            }
            $times--;
        }
    }

//    function testGenerateOutput() {
//        // $times = 20000;
//        $this->markTestSkipped();
//        $this->generateMany($this->times, $this->gmPath);
//    }
 
    function testOutputMatchesGoldenMaster() {
        // $times = 20000;
        $actualPath = '/tmp/actual.txt';
        $this->generateMany($this->times, $actualPath);
        $file_content_gm = file_get_contents($this->gmPath);
        $file_content_actual = file_get_contents($actualPath);
        $this->assertTrue($file_content_gm == $file_content_actual);
    }

}
