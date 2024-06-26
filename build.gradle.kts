import org.gradle.api.tasks.Copy

plugins {
    kotlin("jvm") version "1.9.21"
    application
}

repositories {
    mavenCentral()
}

tasks.jar {
    archiveBaseName.set("Dapp")
    archiveVersion.set("1.0.0")
    // existing configurations skip because I like to cheat. Clean up your crap.
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
    from(sourceSets.main.get().output)
    manifest {
        attributes(
            "Main-Class" to "com.base.DappKt" 
        )
    }
    // Includes all dependencies into the JAR file (creates a fat JAR)
    from(configurations.runtimeClasspath.get().map { if (it.isDirectory) it else zipTree(it) })
}


dependencies {
    implementation("io.javalin:javalin:5.6.3")
    implementation(kotlin("stdlib"))
    implementation("org.slf4j:slf4j-simple:2.0.0")
    implementation("ch.qos.logback:logback-classic:1.2.3")
    implementation("org.slf4j:slf4j-api:1.7.30") 
     // JAXB API
    implementation("javax.xml.bind:jaxb-api:2.3.1")
    // JAXB Core
    implementation("com.sun.xml.bind:jaxb-core:2.3.0.1")
    // JAXB Implementation
    implementation("com.sun.xml.bind:jaxb-impl:2.3.3")
    // Additional dependency to handle annotations
    implementation("javax.annotation:javax.annotation-api:1.3.2")
}

application {
    mainClass.set("com.base.DappKt")
}

// my cheat to make the builds build for everything other than Jar
tasks.processResources {
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
}

sourceSets {
    main {
        resources {
            srcDirs("Development/src/main/resources/")
            include("**/*.html")
        }
    }
}

tasks.withType<JavaExec> {
    args = listOf("server")
}

// A Custom task to clean Rust build outputs
tasks.register("cleanRust") {
    doLast {
        exec {
            commandLine("cargo", "clean", "--manifest-path", "Cargo.toml")
        }
    }
}

// Clean task is called when Gradle clean is run
tasks.named("clean").configure {
    dependsOn("cleanRust")
}

// Task to build Rust
tasks.register("buildRust") {
    doLast {
        exec {
            workingDir("Development/src/main/rust") 
            // working directory is Rust project root
            commandLine("cargo", "build", "--release",)
        }
    }
}

// Rust binaries copy to a specific directory
tasks.register<Copy>("copyRustBinaries") {
    dependsOn("buildRust")
    from("${projectDir}/Development/src/main/rust/target/release/") // Adjust the path as needed
    into("${buildDir}/bin") // Destination directory for the Rust binaries
    // Specify patterns for the files to include, adjust based on your output binaries
    include("**/*") // Include all files for Unix-like OS
}

// Make the build task depend on the copyRustBinaries task
tasks.named("build") {
    dependsOn("copyRustBinaries")
}
