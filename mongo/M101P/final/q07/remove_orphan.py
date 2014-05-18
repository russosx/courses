
import pymongo

connection_string = "mongodb://localhost"
connection = pymongo.MongoClient(connection_string)
db = connection.q07

images = db.images.find()
albums = db.albums

removed = 0

for image in images:
	alb_cnt = albums.find({"images": image["_id"]}).count()
	if (alb_cnt == 0):
		removed += 1
		db.images.remove({"_id": image["_id"]})

print "Docs removed - ", removed