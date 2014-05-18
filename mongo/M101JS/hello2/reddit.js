var MongoClient = require('mongodb').MongoClient,
	request = require('request');

// ******* REMOVE
MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
	if (err) throw err;

	var query = {student: "Zyulo"};

	db.collection('students').remove(query,
		function (err, removed) {
			if (err) throw err;
			console.log('Removed ' + removed);
			return db.close();
		}
	);
});


// ******* FindAndModify
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;

// 	var query = {'name': 'comments'};
// 	var sort = [];
// 	var operator = {'$inc': {'counter': 1}};
// 	var options = {'new': true};

// 	db.collection('counters').findAndModify(query, sort, operator, options,
// 		function(err, doc) {
// 			if (err) throw err;
// 			if (!doc) {
// 				console.log('No counter for comments');
// 			} else {
// 				console.log('Number of comments ' + doc.counter);
// 			}
// 			return db.close();
// 		}
// 	);
// });



// ****** UPSERTS
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;
	
// 	var query = {'student': 'Zyulo', 'age': 37};
// 	// var operator = {'student': 'Zyulo', 'age': 37, 'grade': 100};
// 	var operator = {'$set': {'date_returned': new Date(), 'grade': 100}};
// 	var options = {'upsert': true};

// 	db.collection('students').update(query, operator, options, function(err, upserted) {
// 		if (err) throw err;
// 		console.log('Successfully upserted ' + upserted + ' documents');
// 		return db.close();
// 	});
// });

// ******* SAVE
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;
	
// 	var query = {'student': 'Zyulo', 'age': 37};
// 	db.collection('students').findOne(query, function(err, doc) {
// 		if (err) throw err;
// 		doc.date_returned = new Date();
// 		db.collection('students').save(doc, function(err, saved) {
// 			if (err) throw err;
// 			console.log('Successfully saved ' + saved + ' documents');
// 			return db.close();
// 		});
// 	});
// });


// ******* UPDATES
// 1. replacement
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;
// 	var query = {'student': 'Russ', 'age': 30};
// 	db.collection('students').findOne(query, function(err, doc) {
// 		if (err) throw err;
// 		if (!doc) {
// 			console.log('No documents for qry ' + query.student + ' found');
// 			return db.close();
// 		}
// 		query['_id'] = doc['_id'];
// 		doc['date_returned'] = new Date();
// 		db.collection('students').update(query, doc, function(err, updated) {
// 			if (err) throw err;
// 			console.log('Success ' + updated);
// 			return db.close();
// 		});
// 	})
// });
// 2. in place
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;
// 	var query = {'student': 'Russ', 'age': 30};
// 	var operator = {'$set': {'date_updated': new Date()}};
// 	db.collection('students').update(query, operator, function(err, updated) {
// 		if (err) throw err;
// 		console.log('Successfully updated ' + updated + ' documents');
// 		return db.close();
// 	})
// });
// 3. multi
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;
	
// 	var query = {};
// 	var operator = {'$unset': {'date_updated': true}};
// 	var options = {'multi': true};

// 	db.collection('students').update(query, operator, options, function(err, updated) {
// 		if (err) throw err;
// 		console.log('Successfully updated ' + updated + ' documents');
// 		return db.close();
// 	})
// });



// ******** INSERTING, _id
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;
// 	var doc = {'student': 'Russ', 'age': 30};
// 	db.collection('students').insert(doc, function(err, inserted) {
// 		if (err) {
// 			console.log(err.message);
// 			return db.close();
// 		}
// 		console.dir('Successfully inserted - ' + JSON.stringify(inserted));
// 		return db.close();
// 	});
// });


// ******** SKIP, LIMIT, SORT
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;

// 	var grades = db.collection('reddit');
// 	var cursor = grades.find({});
// 	cursor.skip(1);
// 	cursor.limit(4);
// 	cursor.sort('title', 1);
// 	// cursor.sort([['title', 1], ['medie.oembed.type', -1]]);
// 	// 
// 	// var options = {
// 	// 	'skip': 1,
// 	// 	'limit': 4,
// 	// 	'sort': [['title', 1], ['medie.oembed.type', -1]]
// 	// };
// 	// var cursor = db.collection('reddit').find({}, {}, options);

// 	cursor.each(function(err, doc) {
// 		if (err) throw err;
// 		if (null === doc) {
// 			return db.close();
// 		}
// 		console.dir(doc.title);
// 	});
// });

// ************* PROJECTION ans REGEX
// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;

// 	var query = {title: {'$regex': "Google"}};
// 	// var query = {"media.oembed.type": "video"}; // dot notation
// 	var projection = {title: true, _id: false};

// 	db.collection('reddit').find(query, projection).each(function(err, doc) {
// 		if (err) throw err;
// 		if (null === doc) {
// 			return db.close();
// 		}
// 		console.dir(doc.title);
// 	});
// });

// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;

// 	request('http://www.reddit.com/r/technology/.json', function(error, response, body) {
// 		if (!error && response.statusCode == 200) {
// 			var obj = JSON.parse(body);
// 			var stories = obj.data.children.map(function(story) {
// 				return story.data;
// 			});
// 			db.collection('reddit').insert(stories, function(err, data) {
// 				if (err) throw err;
// 				console.dir(data);
// 				db.close();
// 			});
// 		}
// 	});
// });

// MongoClient.connect('mongodb://localhost:27017/course', function(err, db) {
// 	if (err) throw err;

// });
