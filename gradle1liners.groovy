def now = { -> new Date().format('yyyyMMdd-HH.mm.ss.SSS')}
def nowFilename = { -> ${new Date().format('yyyyMMdd-HHmmssSSS')}
println "now : $now"


// Command to create Gradle wrapper:
gradle wrapper --gradle-version 4.7

upToDateWhen { true }

file(".").listFiles()
	.findAll {it.name.endsWith('.bndrun')}
	.collect{ it.name.substring(0, it.name.lastIndexOf(".")) }	// Strip extension
	.each{ println it }


configurations.all.each { config ->
	println " ${config.name} ".center( 80, '-' )
	config.allArtifacts.getFiles().each { file -> println "$file.name"  }
}

// All configurations 
task prr << {
	configurations.all.each { config ->
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

task printRepos << {
	println "\nRepositories:"
	repositories.each{ println " ${it.name}  -  ${it.url}" }
}


task printArtifacts << {
	println "Archives Artifacts: "
	configurations.archives.allArtifacts.each {
		println it
	}
}

// Print dependencies of build script
task buildScriptDependencies(type: org.gradle.api.tasks.diagnostics.DependencyReportTask) {
	configurations = project.buildscript.configurations
}


/**
 * Print all selected buildscript dependencies of the current project
 */
task printAllSelectedBuildScriptDependencies << {
	buildscript.configurations.classpath { config ->
		def result = config.getIncoming().getResolutionResult()
		println "Nr of dependencies: ${result.allDependencies.size()}"
		def selectedDependencies = result.allDependencies.collect {it.selected}.unique()
		println "${selectedDependencies.size()} unique selected dependencies"
		selectedDependencies.each { dep -> 
			println dep
//			println "$dep.selected"
		}
	}
}
