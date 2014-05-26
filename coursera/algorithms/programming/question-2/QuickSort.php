<?php

// Q1: 157946, 162085
// Q2: 165485, 164123
// Q3: 151823, 138382

$filename = "QuickSort.txt";

$input = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
if ($input !== FALSE) {
	// Q1
	$comps = 0;
	$output = QuickSort($input);
	file_put_contents($filename.".1.out", var_export($output, TRUE));
	echocr($comps);

	// Q2
	$comps = 0;
	$output = QuickSort2($input);
	file_put_contents($filename.".2.out", var_export($output, TRUE));
	echocr($comps);

	// Q3
	$comps = 0;
	$output = QuickSort3($input);
	file_put_contents($filename.".3.out", var_export($output, TRUE));
	echocr($comps);

} else {
	echocr("Error opening file");
}

function QuickSort(array $array) {
	global $comps;
    if(count($array) < 2) return $array;
 
    $left = $right = array();
 
    reset($array);
    $pivot_key = key($array);
    $pivot = array_shift($array);
 
    $comps += count($array);
    foreach($array as $k => $v) {
		if($v < $pivot)
	            $left[$k] = $v;
	        else
	            $right[$k] = $v;
    }
 
    return array_merge(quicksort($left), array($pivot_key => $pivot), quicksort($right));
}

function QuickSort2(array $array) {
	global $comps;
    if(count($array) < 2) return $array;
 
    $left = $right = array();
 
    end($array);
    $pivot_key = key($array);
    $pivot = array_pop($array);
 
    $comps += count($array);
    foreach($array as $k => $v) {
		if($v < $pivot)
	            $left[$k] = $v;
	        else
	            $right[$k] = $v;
    }
 
    return array_merge(quicksort($left), array($pivot_key => $pivot), quicksort($right));
}

function QuickSort3(array $array) {
	global $comps;
    if(count($array) < 2) return $array;
 
    $left = $right = array();
 
    list($pivot_key, $pivot) = MedianOfThreePivot($array);
    unset($array[$pivot_key]);
    $array = array_values($array);
 
    $comps += count($array);
    foreach($array as $k => $v) {
		if($v < $pivot)
	            $left[$k] = $v;
	        else
	            $right[$k] = $v;
    }
 
    return array_merge(quicksort($left), array($pivot_key => $pivot), quicksort($right));
}

function MedianOfThreePivot(array $array) {
	$last_key = count($array) - 1;
	$middle_key = round(($last_key+1)/2);
	$three = [0 => $array[0], $last_key => $array[$last_key], $middle_key => $array[$middle_key]];
	sort($three);
	return [1 => $three[1]];
}

function echobr($message) {
	echo "$message<br>";
}

function echocr($message) {
	echo "$message\n";
}