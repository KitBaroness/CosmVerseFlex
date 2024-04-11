import org.gradle.api.tasks.Copy

plugins {
    kotlin("jvm") version "1.7.10"
    application
}

repositories {
    mavenCentral()
}

tasks.jar {
    archiveBaseName.set("unster")
    archiveVersion.set("1.0.0")
    from(sourceSets.main.get().output)
}

dependencies {
    implementation("io.javalin:javalin:5.6.3")
    implementation(kotlin("stdlib"))
    implementation("org.slf4j:slf4j-simple:2.0.0")
    implementation("ch.qos.logback:logback-classic:1.2.3")
    implementation("org.slf4j:slf4j-api:1.7.30") 
}

application {
    mainClass.set("com.base.UnsterKt")
}

// my cheat to make the builds build
tasks.processResources {
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
}

sourceSets {
    main {
        resources {
            srcDirs("src/main/resources/")
            include("**/*.html")
        }
    }
}

// Add a custom task to clean Rust build outputs
tasks.register("cleanRust") {
    doLast {
        exec {
            commandLine("cargo", "clean", "--manifest-path", "Cargo.toml")
        }
    }
}

// Ensure the Rust clean task is called when Gradle clean is run
tasks.named("clean").configure {
    dependsOn("cleanRust")
}

// Task to build the Rust code
tasks.register("buildRust") {
    doLast {
        exec {
            workingDir("src/main/rust") // Set the working directory to the Rust project root
            commandLine("cargo", "build", "--release",)
        }
    }
}

// Task to copy Rust binaries to a specific directory
tasks.register<Copy>("copyRustBinaries") {
    dependsOn("buildRust")
    from("${projectDir}/src/main/rust/target/release/") // Adjust the path as needed
    into("${buildDir}/bin") // Destination directory for the Rust binaries
    // Specify patterns for the files to include, adjust based on your output binaries
    include("**/*") // Include all files for Unix-like OS
}

// Make the build task depend on the copyRustBinaries task
tasks.named("build") {
    dependsOn("copyRustBinaries")
}
