use enron;

// db.messages.findOne();

db.messages.find({
	"headers.From": "andrew.fastow@enron.com",
	$or: [
		{"headers.To": "jeff.skilling@enron.com"},
		{"headers.Cc": "jeff.skilling@enron.com"},
		{"headers.Bcc": "jeff.skilling@enron.com"}
	]
});

// db.messages.count();
// db.message.find({'headers.From': 'reservations@marriott.com'});