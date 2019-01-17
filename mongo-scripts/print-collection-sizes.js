// Usage: mongo <DATABASE_NAME> < print-collection-sizes.js

// All collections and sorted by size
var collectionNames = db.getCollectionNames(), stats = [];
collectionNames.forEach(function (n) {
	stats.push(db[n].stats());
});

stats = stats.sort(function(a, b) { return b['size'] - a['size']; });

for (var c in stats) {
	var sizeMB = Math.round(stats[c]['storageSize'] / 1000000);
	var indexSizeMB = Math.round(stats[c]['totalIndexSize'] / 1000000);
	sizeMB = sizeMB.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
	indexSizeMB = indexSizeMB.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
	print(stats[c]['ns'] + ": " + sizeMB + " MB  -  index size: " + indexSizeMB + " MB");
}
