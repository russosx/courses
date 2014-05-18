use weather;

db.data.aggregate([
	{$group: {
		_id: {state: "$State"},
		month_high: {$max: "$Temperature"}
	}}
]);

// db.data.find({"Wind Direction": {$gte: 180, $lte: 360}}).sort({'Temperature': 1}).limit(1);
