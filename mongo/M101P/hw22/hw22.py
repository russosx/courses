#!/usr/bin/env python

import pymongo
import sys

print 'Python implementation'
print '---------------------'
# uri = 'mongodb://localhost:27017/'
uri = 'mongodb:///opt/local/var/db/mongod/mongodb-27017.sock'
conn = pymongo.MongoClient(uri)
db = conn.students
col_grades = db.grades;

cl_where = {'type':'homework'}
cl_sort = [
	('student_id', pymongo.ASCENDING), 
	('score', pymongo.DESCENDING)
]
col_suspected = []

try:
	col_suspected = col_grades.find(cl_where).sort(cl_sort)
	print 'Total:', col_suspected.count()
except:
	print sys.exc_info()[0]

student_id = 0;
deleted = 0;
for guy in col_suspected:
	if (student_id != guy['student_id']):
		col_grades.remove({'student_id':student_id})
		print student_id, 'deleted'
		deleted += 1
		student_id = guy['student_id']
	print guy

print 'Deleted', deleted
