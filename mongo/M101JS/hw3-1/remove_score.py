#!/usr/bin/env python

import pymongo

uri = 'mongodb:///opt/local/var/db/mongod/mongodb-27017.sock'
conn = pymongo.MongoClient(uri)
db = conn.school
col_students = db.students;

def remove_homework_lowest(scores):
	max = 100
	for score in scores:
		if ((score['type'] == 'homework') and (score['score'] < max)):
			max = score['score']
			score_to_delete = score
	scores.remove(score_to_delete)

students = col_students.find({})
for student in students:
	# print 'was: ', student['scores']
	remove_homework_lowest(student['scores'])
	# print 'will: ', student['scores']
	col_students.save(student)
