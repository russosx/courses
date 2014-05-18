var MongoClient = require('mongodb').MongoClient;

MongoClient.connect('mongodb://localhost:27017/weather', function(err, db) {
	if (err) throw err;

	var order = [["State", 1], ["Temperature", -1]];

	var options = {
		'sort': order
	};

	var state = '';
	var cursor = db.collection('data').find({}, {}, options).each(
		function (err, doc) {
			if (err) throw err;

			if (null === doc) {
				return db.close();
			}

			if (doc["State"] !== state) {
				console.log(doc["State"] + ': ' + doc["Temperature"]);

				var query = {};
				query["_id"] = doc["_id"];
				doc["month_high"] = true;

				db.collection("data").update(query, doc,
					function (err, updated) {
						if (err) throw err;
						console.log("updated " + updated);
					}
				);

				state = doc["State"];
			}
		}
	);
});