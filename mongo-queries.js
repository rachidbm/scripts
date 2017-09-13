// Mongo commands
mongorestore .
mongodump


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


// delete newer than date
db.posts.remove({date: {"$gt": new ISODate("2017-08-25T07:47:53.501Z")}})


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


