```     ___           ___           ___                       ___           ___     
     /__/\         /__/\         /  /\          ___        /  /\         /  /\    
     \  \:\        \  \:\       /  /:/_        /  /\      /  /:/_       /  /::\   
      \  \:\        \  \:\     /  /:/ /\      /  /:/     /  /:/ /\     /  /:/\:\  
  ___  \  \:\   _____\__\:\   /  /:/ /::\    /  /:/     /  /:/ /:/_   /  /:/~/:/  
 /__/\  \__\:\ /__/::::::::\ /__/:/ /:/\:\  /  /::\    /__/:/ /:/ /\ /__/:/ /:/___
 \  \:\ /  /:/ \  \:\~~\~~\/ \  \:\/:/~/:/ /__/:/\:\   \  \:\/:/ /:/ \  \:\/:::::/
  \  \:\  /:/   \  \:\  ~~~   \  \::/ /:/  \__\/  \:\   \  \::/ /:/   \  \::/~~~~ 
   \  \:\/:/     \  \:\        \__\/ /:/        \  \:\   \  \:\/:/     \  \:\     
    \  \::/       \  \:\         /__/:/          \__\/    \  \::/       \  \:\    
     \__\/         \__\/         \__\/                     \__\/         \__\/   
     
```


README.md
==========

### Project: Unster Application
===========================

### Introduction
------------
* This Unster Application is a simple Kotlin-based web project using Javalin to serve a web page and handle backend logic. 
* The project includes a `unster.kt` Kotlin file as the main class and a `home.html` file for the frontend.

#### Prerequisites
-------------
- JDK (Java Development Kit) 1.8 or higher https://hg.openjdk.java.net/
      'sudo apt install openjdk-17-jdk'
- Kotlin 1.7.10 or higher https://kotlinlang.org/download/ (1.9.21)
- Gradle Build Tool (preferably the latest version) https://javalin.io/tutorials/gradle-setup
- An IDE that supports Kotlin https://github.com/VSCodium/vscodium/releases (1.82.2)
- Maven https://javalin.io/tutorials/maven-setup (3.6.3)
- Javalin https://github.com/javalin/javalin (5.6.3)
- Rust 1.77.0 or higher
  - Cargo (Rust's build tool & package manager)
  - ToolChain Manager Stable

#### Project Structure
-----------------
- `src/main/kotlin/com/base/`: Contains Kotlin source files.
- `src/main/resources/static`: Houses static resources like HTML files for the frontend.
- `src/main/rust/`: Contains Rust source files for file processing tasks.
- `scripts/indexing.sh`: Bash script to automate file processing and deduplication tasks.
- `target/`: Rust build artifacts are placed here by Cargo.
- `Cargo.toml`: Configuration file for Rust project management.

### Configuration
The application's configuration files are located in the `config/` directory. This includes logging configurations and any other necessary settings for the application to run.

- For logging in Kotlin, update the `src/main/resources/logback.xml` with your desired logging levels and patterns.
- For logging in Rust, you can set the `RUST_LOG` environment variable, or implement a custom configuration reader that uses the `config/` directory.


### Execution Flow
  #### File Preprocessing:

- Rust code in preprocess_file.rs cleans the files in SOURCE_DIR.
Processed files are stored in `PROCESSED_DIR.`
#### File Deduplication:
- Rust code in deduplicate.rs removes duplicates from files in `PROCESSED_DIR.`
Deduplicated files are stored in `DEDUP_DIR.`
Script Automation:
- The  `indexing.sh` shell script calls the Rust binaries to automate preprocessing and deduplication.
This script can be triggered manually or set up as a cron job for periodic execution.
Database Indexing:

If database indexing is part of the process, include logic in the Rust code or another script that reads from DEDUP_DIR and updates the database accordingly.
Ensure your Rust binaries are compiled and located in a directory that the indexing.sh script knows about. If they're part of the release build, you may need to adjust the paths in the script to point to target/release instead of the current relative paths.

#### Setup Instructions
------------------
1. FORK then Clone your own forked repo.
2. Open the project in your IDE aka VSCodium
3. Ensure that the JDK is properly set up in your IDE.

#### FOR DOCKER IMAGE
* Go to unster directory in terminal
 - Build the Docker image
`docker build -t unster-image .`
 - Run the Docker container
`docker run -p 8080:8080 unster-image`


#### Building the Project
--------------------
- For Kotlin components:
  - Build: `./gradlew build`
  - Run: `./gradlew run`

- For Rust components:
  - Build: `cargo build`
  - Run: `cargo run --bin my_binary`

1. Navigate to the root directory of the project via the terminal or command prompt.
2. Run the following command to build the project: 'gradle clean build'
  - To use the Gradle Wrapper use `./gradlew clean build`
  - If ./gradlew permission is denied run `chmod +x gradlew`
3. If the build is successful, you should see a BUILD SUCCESSFUL message in the terminal.

- - - - - - - - - - - - - 
```
                                  _                     
     )|(           +++           ((_           \|/      
    (o o)         (o o)         (o o)         (o o)     
ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-ooO--(_)--Ooo-
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
```

### Running the Application
-----------------------
#### To clean Rust artifacts
`./gradlew cleanRust`      

#### To build Rust code
`./gradlew buildRust`

#### To copy the built binaries to the specified directory
`./gradlew copyRustBinaries`

#### To build your entire project, including Rust components
`./gradlew build`

1. To run the application, execute:
`gradle run`
   * or
`./gradlew run`

4. Once the application starts, it will be accessible at `http://localhost:8080`.
5. Open a web browser and navigate to `http://localhost:8080` to view the `home.html` page.

### Running File Processing and Deduplication

Execute the `indexing.sh` script to start the file processing and deduplication. This script will look for files in the specified source directory and perform operations.
* Edit your directories you wish to use

```bash
./scripts/indexing.sh [source_directory] [processed_directory] [dedup_directory]

Important Notes
---------------
- The `home.html` file is served as a static file by the Javalin server running in `unster.kt`.
- Any changes to the Kotlin files will require a rebuild of the project.
- For detailed information on the project's functionality and API endpoints, refer to the inline comments in the `unster.kt` file.

```

#### If no directories are specified, it will use the defaults defined within the script.

### Customizing Paths
Users can customize the source, processed, and deduplication paths by providing them as arguments when running the indexing.sh script.

#### Additional Information
-The Rust binaries for preprocessing and deduplication need to be compiled before   running the indexing.sh script.
    -The `indexing.sh` script can be set up as a cron job for periodic execution.

```
***************************************************
*  ____  ___   ___  ____    _    _   _  ____ _  __*
* / ___|/ _ \ / _ \|  _ \  | |  | | | |/ ___| |/ /*
*| |  _| | | | | | | | | | | |  | | | | |   | ' / *
*| |_| | |_| | |_| | |_| | | |__| |_| | |___| . \ *
* \____|\___/ \___/|____/  |_____\___/ \____|_|\_\*
*************************************************** 
```
-------


### Contributions and Contact
* For contributions, please open a pull request or an issue.
* For questions or support, contact @NinjaAssPirate | @KitBaroness

- - - - - - - - - 
# Process Flow {MANIFESTO}

## File Preprocessing

- The `preprocess_file.rs` Rust script cleans input files by performing operations such as special character removal and whitespace trimming.
- Cleaned files are directed to the directory defined by `PROCESSED_DIR`.

## File Deduplication

- The `deduplicate.rs` Rust script processes cleaned files to remove duplicate entries, ensuring data uniqueness.
- Unique data entries are saved to the directory indicated by `DEDUP_DIR`.

## Automation via Script

- The `indexing.sh` script manages the file processing workflow, triggering the Rust scripts for preprocessing and deduplication tasks.
- This script may be run manually or set as a cron job for routine operations.

## Optional Database Indexing

- In cases where data needs to be indexed into a database, either the Rust code is expanded or a supplementary script, `update_database.sh`, is implemented to import data from `DEDUP_DIR` to the chosen database system.

# File and Script Interaction

## Rust Scripts

- `preprocess_file.rs` and `deduplicate.rs` are Rust scripts that independently manage data cleaning and deduplication.

## Shell Script

- `indexing.sh` is a Bash script that sequentially initiates Rust scripts, managing the flow from raw data input to deduplicated output.

# Build and Application Configuration

## Gradle Build Configuration (`build.gradle.kts`)

- Set up to compile Rust code, define clean-up tasks, copy binaries, and integrate with the Kotlin build process.

## Kotlin Application (`Unster.kt`)

- Serves as the Kotlin application's entry point, employing Javalin to handle web content delivery and HTTP request management.

## Logging Configuration (`logback.xml` and `logging.conf`)

- Determine logging practices, specifying output, format, level, and target destination for log messages.

## Gradle Wrapper

- Ensures consistent Gradle usage across different environments by using a specific version embedded in the project.

## Logging Implementation

- Integrates SLF4J for logging within Kotlin code, with configurations managed by `logback.xml`.

# User-Defined Path Configuration

- To allow for user-defined paths, the system can utilize environment variables or command-line arguments.
- These are read by the `indexing.sh` script and passed to Rust scripts accordingly.

# Project Structure and Manifest

## Cargo Manifest (`Cargo.toml`)

- Outlines Rust project dependencies and build settings.

# Execution Overview

1. `indexing.sh` is initiated by a user or a scheduled job.
2. The script calls `preprocess_file.rs` to process files in `SOURCE_DIR`.
3. Processed files are placed in `PROCESSED_DIR`.
4. `indexing.sh` triggers `deduplicate.rs` to process files in `PROCESSED_DIR`.
5. Deduplicated files are deposited in `DEDUP_DIR`.
6. Optionally, `update_database.sh` is used to populate a database with the data in `DEDUP_DIR`.

This structured approach ensures systematic handling of data from initial processing to potential database integration.