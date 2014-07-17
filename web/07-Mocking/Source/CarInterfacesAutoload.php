<?php

foreach (scandir(dirname(__FILE__) . '/CarInterface') as $filename) {
    $path = dirname(__FILE__) . '/CarInterface/' . $filename;

    if (is_file($path)) {
        require_once $path;
    }
}