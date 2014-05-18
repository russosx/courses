use ref;

db.zips.aggregate([
	{$group: {
		_id: {city: "$city", state: "$state"},
		pop: {$sum: "$pop"}
	}},
	{$match: {
		"_id.state": {$in: ["CA", "NY"]},
		pop: {$gt: 25000}
	}},
	{$group: {
		_id: null,
		avg: {$avg: "$pop"}
	}}
])

// db.zips.aggregate([
// 	{$match: {
// 		state: {$in: ["CT", "NJ"]},
// 		pop: {$gt: 25000}
// 	}},
// 	{$group: {
// 		_id: null,
// 		cnt: {$sum: 1},
// 		avg: {$avg: "$pop"},
// 		sum: {$sum: "$pop"}
// 	}}
	// ,{$group: {
	// 	_id: "null",
	// 	pop: {$avg: "$pop"}
	// }},
	// ,{$sort: {
	// 	"_id.city": 1,
	// 	pop: -1
	// }}
	// , {$sort: {
	// 	"_id.city": 1
	// }}
	// ,{$limit: 5}
// ])

// db.zips.count();
// db.zips.findOne();
// db.runCommand({
// 	count: 'zips',
// 	query: {state: "CT", pop: {$gt: 25000}}
// })