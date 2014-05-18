<?php

// $filename = "IntegerArrayTest.txt";
$filename = "IntegerArray.txt";

if ( ($input = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES)) !== FALSE ) {
	var_dump(SortAndCount($input));
} else {
	echo "Error opening file\n";
}

function SortAndCount(array $A) 
{
	$l = count($A);
	if ($l < 2) {
		return 0;
	}
	
	$m = round( (($l + 1) / 2), PHP_ROUND_HALF_DOWN);
	$left = array_slice($A, 0, $m);
	$right = array_slice($A, $m, $l);

	$x = SortAndCount($left);
	$y = SortAndCount($right);
	$z = MergeAndCountSplit($A, $left, $right);

	return  $x + $y + $z;
}

function MergeAndCountSplit(array $A, array $left, array $right) 
{
	$i = 0; $j = 0; $count = 0;
	$NL = count($left);
	$NR = count($right);
	while ($i < $NL || $j < $NR) {
		if ($i == $NL) {
			$A[$i+$j] = $right[$j];
			$j++;
		} else
		if ($j == $NR) {
			$A[$i+$j] = $left[$i];
			$i++;
		} else
		if ($left[$i] < $right[$j]) {
			$A[$i+$j] = $left[$i];
			$i++;
		} else {
			$A[$i+$j] = $right[$j];
			$count += $NL - $i;
			$j++;
		}
	}
	return $count;
}
