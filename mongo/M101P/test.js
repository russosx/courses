use ref;

db.zips.aggregate([
	{$match : {
		"state": "NY"
	}},
	{$group: {
		_id: "$city",
		population: {$sum: "$pop"}
	}},
	{$project: {
		_id: 0,
		city: "$_id",
		population: 1
	}},
	{$sort: {
		"population": -1
	}},
	{$skip: 10},
	{$limit: 5}
]);

// db.zips.aggregate([
// 	{$match: {
// 		"pop": {$gt: 100000}
// 	}}
// ]);

// db.zips.aggregate([
//     {
//     	$project: {
//     		_id: 0,
//     		"city": {$toLower:"$city"},
//     		"pop": 1,
//     		"state": 1,
//     		"zip": "$_id"
//     	}
//     }
// ]);

