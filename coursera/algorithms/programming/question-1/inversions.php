<?php


$filename = "IntegerArrayTest.txt";
// $filename = "IntegerArray.txt";

if ( ($input = file($filename, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES)) !== FALSE ) {
	var_dump(SortAndCount($input));
} else {
	echo "Error opening file\n";
}

function SortAndCount(array $A) {

	$L = count($A);

	if ( $L  <= 1 )
		return [$A, 0];

	if ( $L == 2 ) {
		$i = 0;
		if ($A[0] > $A[1]) {
			$i = 1;
		}
		sort($A);
		return [$A, $i];
	}

	list($B, $x) = SortAndCount(LeftArray($A, $L/2));
	list($C, $y) = SortAndCount(RightArray($A, $L/2));
	list($D, $z) = MergeAndCountSplit($B, $C);

	return [$D, $x + $y + $z];
}

function MergeAndCountSplit(array $B, array $C) {
	$D = [];
	$z = 0;
	$i = 0; $j = 0;
	$N = count($B);
	for ($k = 0; $k < $N; ++$k) {
		if ($B[$i] < $C[$j]) {
			$D[$k] = $B[$i];
			$i++;
		} else if ($C[$j] > $B[$i]) {
			$D[$k] = $C[$j];
			$j++;
			$z++;
		}
	}
	return [$D, $z];
}

function LeftArray(array $A, $c) {
	$n = round($c);
	return array_slice($A, 0, $n);
}

function RightArray(array $A, $c) {
	$n = round($c);
	return array_slice($A, -$n);
}
