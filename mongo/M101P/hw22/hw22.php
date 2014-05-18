<?php

echo "PHP implementation\n";
echo "------------------\n";

// $uri = 'mongodb://localhost:27017/';
$uri = 'mongodb:///opt/local/var/db/mongod/mongodb-27017.sock';
$conn = new MongoClient($uri);
$db = $conn->students;

try {
	$col_grades = $db->grades
		->find(array(
			'type' => 'homework',))
		->sort(array(
			'student_id' => MongoCollection::ASCENDING,
			'score' => MongoCollection::DESCENDING,
		)); 

	echo "Total: {$col_grades->count()}\n";
} catch (Exception $e) {
	echo "Error: {$e->message}\n";
	exit(-1);
}

$deleted = 0;
$student_id = 0;
foreach ($col_grades as $guy) {
	if ($student_id != $guy['student_id']) {
		try {
			$db->grades->remove(array(
				'_id' => $_id,
			));
			echo "$_id deleted\n";
		} catch (Exception $e) {
			echo "Error: {$e->message}\n";
			break;
		}
		$student_id = $guy['student_id'];
		++$deleted;
	}
	$_id = $guy['_id'];
	var_dump($guy);
}

$conn->close();

echo "Deleted: $deleted\n";