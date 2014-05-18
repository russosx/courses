use enron;

db.messages.aggregate([
	{$unwind: "$headers.To"},
	{$group: {
		_id: {to: "$headers.From", from: "$headers.To"},
		message_count: {$sum: 1}
	}},
	{$sort: {
		"message_count": -1
	}},
	{$limit: 5}
]);