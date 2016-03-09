def now = { -> new Date().format('yyyyMMdd-HH.mm.ss.SSS')}
println "now : $now"


file(".").listFiles()
	.findAll {it.name.endsWith('.bndrun')}
	.collect{ it.name.substring(0, it.name.lastIndexOf(".")) }	// Strip extension
	.each{ println it }


configurations.all.each { config ->
	config.allArtifacts.getFiles().each { file -> println "$file.name     -     $config"  }
}

// All configurations 
task prr << {
	configurations.findAll().each { config ->
		println " - $config"
	}
}

// Print all dependencies of the current project
task printDependencies << {
  project.configurations.all.findAll { !it.allDependencies.empty }.each { config ->
    println " ${config.name} ".center( 80, '-' )
    config.allDependencies.each { dep ->
        println "$dep.group:$dep.name:$dep.version"
    }
  }
}


task prr << {
	println "\nRepositories:"
	repositories.each{ println " ${it.name}  -  ${it.url}" }
}


task prr << {
	println "Archives Artifacts: "
	configurations.archives.allArtifacts.each {
		println it
	}
}

