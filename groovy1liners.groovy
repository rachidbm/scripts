

file(".").listFiles()
	.findAll {it.name.endsWith('.bndrun')}
	.collect{ it.name.substring(0, it.name.lastIndexOf(".")) }	// Strip extension
	.each{ println it }


configurations.findAll().each { config ->
	config.allArtifacts.getFiles().each { file -> println "$file.name     -     $config"  }
}