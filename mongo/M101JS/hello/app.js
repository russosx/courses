
var port = 8082;

// ******* Express module
var express = require('express'),
	app = express(),
	cons = require('consolidate');

// **** DB
var MongoClient = require('mongodb').MongoClient,
	MongoServer = require('mongodb').Server;

var mongoClient = new MongoClient(
	new MongoServer('localhost', 27017, {'native_parser': true})
);
var db = mongoClient.db('test');

// template engine
app.engine('html', cons.swig);
app.set('view engine', 'html');
app.set('views', __dirname + '/views');

// error Handler
function errorHandler(err, req, resp, next) {
	console.error(err.message);
	console.error(err.stack);
	resp.status(500);
	resp.render('internal_error', {error: err});
}
app.use(errorHandler);

// routing

app.get('/', function (req, resp, next) {
	db.collection('fubar').find({}, function (err, docs) {
		resp.render('docs', docs);
	});
});

app.get('/:name', function (req, resp) {
	db.collection('fubar').findOne({}, function (err, doc) {
		doc.name = req.params.name + req.query.var1;
		resp.render('hello', doc);
	});
	// resp.render('hello', {name: 'Zyuilo'});
});

app.get('*', function (req, resp) {
	resp.send('Not found, Xyulo', 404);
});

// run
mongoClient.open(function (err, mongoClient) {
	if (err) throw err;
	app.listen(port);
});

// ******* Express module

// ******** Basic style + Mongo
// var http = require('http'),
// 	mongoClient = require('mongodb').MongoClient,
// 	connectionString = "mongodb://localhost:27017/test";

// var server = http.createServer(function (request, respond) {
// 	mongoClient.connect(connectionString, function (err, db) {
// 		if (err) throw err;

// 		db.collection('fubar').findOne({}, function (err, doc) {
// 			if (err) throw err;

// 			respond.writeHead(200, {'Content-Type': 'application/json'});
// 			respond.end(JSON.stringify(doc));

// 			// console.dir(doc);
// 			db.close();
// 		});
// 	});
// });

// server.listen(8082);
// ******** Basic style + Mongo

console.log('Server running on http://localhost: ' + port);