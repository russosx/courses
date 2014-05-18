# import pymongo
from pymongo import MongoClient

connection = MongoClient('mongodb://localhost:27017/')
db = connection.test
names = db.names
item = names.find_one()
print item['name']

new_name = {
	'name': 'Nata',
	'address': {
		'city': 'Pristan',
		'street': 'Kalinina'
	},
	'loves': ['Russ', 'Serge', 'Vitalik']
}
names.insert(new_name)
