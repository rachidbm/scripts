// Mongo commands
mongorestore .
mongodump

mongoimport --drop -d students -c grades grades.json


https://docs.mongodb.com/manual/reference/sql-aggregation-comparison/

// Size of Document in Mongo
Object.bsonsize(db.devices.findOne({}))


time mongo --eval "db.getSiblingDB('statsserver').dailyRecords.createIndex({ 'roomunit': 1 });"
mongo --eval "db.getSiblingDB('statsserver').dailyRecords.distinct('roomunit')"

// sort by date
db.getCollection('event').find({}).sort({"date": -1}).limit(10)
db.dailyHistory.find({}).sort({"date": -1}).limit(10)

// certain date
db.getCollection('user').find({date: ISODate("2016-05-10T00:00:00.000Z")}, {_id: -1, username: 1})

// drop a collection
mongo --eval "db.getSiblingDB('statsserver').dailyRecords.drop();"

// Find the nr of histor docs for 1 RU from commandline
time mongo --eval "db.getSiblingDB('statsserver').dailyRecords.find({'uuid': '0009fb52-7dca-4a20-a9e3-304e5a507339'}).count();"

// random document
db.coll.aggregate( { $sample: { size: 1 } } ).limit(5);

// has a certain field
db.coll.find({"address.street":{"$exists":1}}).count()

// all documents not equal to
db.getCollection('address').find({_id: {"$ne" : ObjectId("5bec1c1f34fc09ba1ba5330d")}});

// delete newer than date
db.posts.remove({date: {"$gt": new ISODate("2017-08-25T07:47:53.501Z")}})

// where key exists
db.getCollection('posts').find({"comments.num_likes": {$exists: true}})

// Remove field from Document
db.posts.update({ "_id" : ObjectId("1234" )}, {$unset:{'fieldname': "" }});


// Remove without waiting (ie write concern)
db.posts.remove({ "_id" : ObjectId("1234" )}, {w: 0});

// length of array

db.coll.aggregate([{
	$project: {
		"name" : 1, 
		"nr of items": {
			$size: { 
				"$ifNull": ["$arrayField", []] 
			}
		}
	}
}]);


// Count the records per eventname + date  with group by, for 1 certain date. 
var allDocs = dailyRecords.aggregate([
	{
		$match: {
			date: ISODate("2017-02-15T00:00:00.000Z")
		}
	},
	{
		$group: {
			_id: {
				eventname: "$eventname",
				date: "$date"
			},
			count: { $sum: 1 }
		}
	},
]);


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



// All collections and sorted by size
var collectionNames = db.getCollectionNames(), stats = [];
collectionNames.forEach(function (n) { stats.push(db[n].stats()); });
stats = stats.sort(function(a, b) { return b['size'] - a['size']; });
for (var c in stats) { 
	var sizeMB = Math.round(stats[c]['storageSize'] / 1000000);
	sizeMB = sizeMB.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
	print(stats[c]['ns'] + ": " + stats[c]['size'] + " (" + sizeMB + " MB)"); 
}




//////////////////////////////
//		Admin stuff
//////////////////////////////

// show stats in GB instead of bytes
db.stats(1024*1024*1024)


db.repairDatabase();


use admin;
db.auth()

db.runCommand( { serverStatus: 1 } )

////// Rotate Mongo's log file:

// In mongo shell run:

db.adminCommand( { logRotate : 1 } )

// Or directly from bash:
/bin/kill -SIGUSR1 `cat /var/run/mongodb/mongod.pid 2>/dev/null`


// Add to systems logrotate:

cat /etc/logrotate.d/mongod.conf 

/var/log/mongodb/mongod.log {
  daily
  size 300M
  rotate 10
  missingok
  compress
  delaycompress
  notifempty
  create 640 mongod mongod
  sharedscripts
  postrotate
    /bin/kill -SIGUSR1 `cat /var/run/mongodb/mongod.pid 2>/dev/null` >/dev/null 2>&1
  endscript
}

