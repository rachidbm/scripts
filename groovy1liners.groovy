def now = { -> new Date().format('yyyyMMdd-HH.mm.ss.SSS')}
println "now : $now"


file(".").listFiles()
	.findAll {it.name.endsWith('.bndrun')}
	.collect{ it.name.substring(0, it.name.lastIndexOf(".")) }	// Strip extension
	.each{ println it }


configurations.all.each { config ->
	config.allArtifacts.getFiles().each { file -> println "$file.name     -     $config"  }
}

// Print all dependencies of the current project
project.configurations.all.findAll { !it.allDependencies.empty }.each { c ->
    println " ${c.name} ".center( 80, '-' )
    c.allDependencies.each { dep ->
        println "$dep.group:$dep.name:$dep.version"
    }
}
