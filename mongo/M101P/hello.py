
import bottle
from pymongo import MongoClient

@bottle.route('/')
def index():
	conn = MongoClient('mongodb://localhost:27017/')
	db = conn.test
	coll_names = db.names
	item = coll_names.find_one()
	return '<h4>Hello, %s!</h4>' % item['name']

bottle.run(host='localhost', port=8080)