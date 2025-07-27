allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)
/*
subprojects {
    afterEvaluate {
        // Only configure if the android extension is present
        extensions.findByName("android")?.let { ext ->
            // Cast the extension to the correct type
            (ext as? com.android.build.gradle.BaseExtension)?.apply {
                this.namespace = "com.fluwix"
            }
        }
    }
}
*/
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
