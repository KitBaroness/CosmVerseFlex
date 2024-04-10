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

### Project: Wallet Application ***EXAMPLE***
===========================

### Introduction
------------
* This Wallet Application is a simple Kotlin-based web project using Javalin to serve a web page and handle backend logic. 
* The project includes a `Wallet.kt` Kotlin file as the main class and a `home.html` file for the frontend.

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

#### Project Structure
-----------------
- `src/main/kotlin/com/wallet/`: Contains Kotlin source files.
- `src/main/resources/static`: Houses static resources like HTML files for the frontend.
- `src/main/rust/`: Contains Rust source files for file processing tasks.
- `scripts/indexing.sh`: Bash script to automate file processing and deduplication tasks.
- `target/`: Rust build artifacts are placed here by Cargo.
- `Cargo.toml`: Configuration file for Rust project management.

#### Setup Instructions
------------------
1. FORK then Clone your own forked repo.
2. Open the project in your IDE aka VSCodium
3. Ensure that the JDK is properly set up in your IDE.

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
- The `home.html` file is served as a static file by the Javalin server running in `Wallet.kt`.
- Any changes to the Kotlin files will require a rebuild of the project.
- For detailed information on the project's functionality and API endpoints, refer to the inline comments in the `Wallet.kt` file.

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


