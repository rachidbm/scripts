print( "All databases: ")
db.getMongo().getDBNames().forEach(function(i){ print('\t', db.getSiblingDB(i))})

db.getMongo().getDBNames().forEach(function(dbName) {
  if(dbName.match("^test-")) { 
  		db.getSiblingDB(dbName).dropDatabase()
  		print("Dropped: ", dbName);
  }
});
