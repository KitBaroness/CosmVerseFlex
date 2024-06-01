```     ___           ___           ___                       ___           ___     
███████╗██╗     ███████╗██╗  ██╗███╗   ██╗███████╗████████╗    ███████╗████████╗ █████╗  ██████╗██╗  ██╗
██╔════╝██║     ██╔════╝╚██╗██╔╝████╗  ██║██╔════╝╚══██╔══╝    ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
█████╗  ██║     █████╗   ╚███╔╝ ██╔██╗ ██║█████╗     ██║       ███████╗   ██║   ███████║██║     █████╔╝ 
██╔══╝  ██║     ██╔══╝   ██╔██╗ ██║╚██╗██║██╔══╝     ██║       ╚════██║   ██║   ██╔══██║██║     ██╔═██╗ 
██║     ███████╗███████╗██╔╝ ██╗██║ ╚████║███████╗   ██║       ███████║   ██║   ██║  ██║╚██████╗██║  ██╗
╚═╝     ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝       ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
                                                                                                        
```
README.md

```
# Fork & Clone the repository with all the submodules with command
git clone --recurse-submodules git@github.com:YourUsername/CosmVerseFlex.git
cd CosmVerseFle`

#Example
git clone --recurse-submodules git@github.com:KitBaroness/CosmVerseFlex.git

# Initialise Submodules
git submodule update --init --recursive
```
==========
## Introduction
Dapp Application is a robust web application leveraging Kotlin with Javalin for serving web content compatibility, integrated with Rust for data processing and shell scripts for automation. The project's core lies in its ability to efficiently process data while offering a user-friendly interface.
  * This Dapp Application is a React web project using Javalin to serve a web page and handle backend logic. 


#### Prerequisites
-------------
- JDK (Java Development Kit) 1.8 or higher
```
sudo apt install wget apt-transport-https -y
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /usr/share/keyrings/adoptium.asc
echo "deb [signed-by=/usr/share/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb focal main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update
sudo apt install temurin-21-jdk -y
```
- Kotlin 1.7.10 or higher https://kotlinlang.org/download/ (1.9.21)
- Gradle Build Tool (preferably the latest version) https://javalin.io/tutorials/gradle-setup
- An IDE that supports Kotlin https://github.com/VSCodium/vscodium/releases (1.82.2)
- Maven https://javalin.io/tutorials/maven-setup (3.6.3)
- Javalin https://github.com/javalin/javalin (5.6.3)
- Rust 1.77.0 or higher `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
  - Cargo (Rust's build tool & package manager) 
    - if you don't have permissions for cargo bin `chmod +x $HOME/.cargo/bin/cargo`
  - ToolChain Manager Stable `rustup install stable` `rustup default stable`

#### Project Structure
-----------------
- `Development/src/main/kotlin/com/base/`: Contains Kotlin source files.
- `Development/src/main/resources/static`: Houses static resources like HTML files for the frontend.
- `Development/src/main/rust/`: Contains Rust source files for file processing tasks.
- `Development/scripts/indexing.sh`: Bash script to automate file processing and deduplication tasks.
- `target/`: Rust build artifacts are placed here by Cargo.
- `Cargo.toml`: Configuration file for Rust project management.

## Project Structure
=============
```
cosmverseflex.git
|
├── Development (cosmverse.git)
│   |
|   src/
│   ├── main/
│   │   ├── kotlin/
│   │   │   └── com/
│   │   │       └── base/
│   │   │           └── DappKt.kt  # Main Kotlin server file
│   │   │
│   │   ├── resources/
│   │   │   └── static/
│   │   │       └── home.html        # Main entry point for the frontend
│   │   │
│   │   └── rust/
│   │       ├── preprocess_file.rs  # Rust script for preprocessing data
│   │       └── deduplicate_file.rs # Rust script for deduplicating data
│   │
│   └── scripts/
│   |    └── indexing.sh             # Shell script for managing tasks
│   │
│   │
│   └── Telegram-bot-api
│   
├── build.gradle.kts                # Gradle build configuration file
├── settings.gradle.kts             # Gradle settings file
└── gradlew                         # Gradle wrapper executable
```
### Execution Flow
* File Preprocessing:

  - Rust code in `preprocess_file.rs` cleans files in `SOURCE_DIR`.
Processed files are stored in `PROCESSED_DIR`.
* File Deduplication:

  - Rust code in deduplicate.rs removes duplicates from files in `PROCESSED_DIR`.
  - Deduplicated files are stored in `DEDUP_DIR`.
* Script Automation:

  - `indexing.sh` shell script automates preprocessing and deduplication, triggerable manually or via cron job.
Database Indexing (if applicable):

* Include logic in Rust code or additional scripts to update databases using data from `DEDUP_DIR`.

#### Setup Instructions
------------------
1. FORK then Clone your own forked repo.
2. Open the project in your IDE aka VSCodium
3. Ensure that the JDK is properly set up in your IDE.

#### FOR DOCKER IMAGE
* Go to Dapp directory in terminal
```
# If you Don't have Docker
mkdir -p ~/.docker/cli-plugins/
curl -L "https://github.com/docker/buildx/releases/download/v0.13.1/buildx-v0.13.1.linux-amd64" -o ~/.docker/cli-plugins/docker-buildx
chmod a+x ~/.docker/cli-plugins/docker-buildx
export DOCKER_CLI_PLUGIN_DIR=~/.docker/cli-plugins
```
```
export DOCKER_BUILDKIT=1
 # Build the Docker image
DOCKER_BUILDKIT=1 docker build -t dapp-application .
 # Run the Docker container
docker run -p 8080:8080 dapp-application
```


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

4. Once the application starts, it will be accessible at `http://localhost:3000`.
5. Open a web browser and navigate to `http://localhost:3000` to view the application page.

### `.gitmodules` Configuration
-Ensure your .gitmodules file at the root of CosmVerseFlex is configured as follows:
```
[submodule "Development"]
  path = Development
  url = git@github.com:YourUsername/cosmverse.git

[submodule "telegram-bot-api"]
  path = telegram-bot-api
  url = git@github.com:YourUsername/telegram-bot-api.git

```
### Git Configurations
- If the submodule configuration needs to be updated, run:
```
git config -f .gitmodules submodule.Development.path Development
git config -f .gitmodules submodule.Development.url git@github.com:KitBaroness/cosmverse.git

git config -f .gitmodules submodule.telegram-bot-api.path telegram-bot-api
git config -f .gitmodules submodule.telegram-bot-api.url git@github.com:YourUsername/telegram-bot-api.git
```
## Containerisation
```
#build using Docker if a Dockerfile is provided
docker build -t cosmverse-flex .
```
### Running the Application
`docker run -p 3000:3000 cosmverse-flex`

## How Each Component Works
- - - - - - - - - - - -

#### Kotlin/Javalin Server (DappKt.kt):

#### This is the core of your server application. It initializes a Javalin server which listens on port 3000.
The server configures static file handling to serve home.html directly from the /static directory. This setup ensures that users can access the web interface by navigating to `http://localhost:3000/home.html` in their browser.
The server also defines endpoints for API operations which might interact with the Rust scripts or handle other backend logic.
HTML Frontend (home.html):

* Located in the `/static` directory, this file acts as the main interface for user interaction. It includes forms and scripts to communicate with the backend via AJAX requests, handling tasks such as user verification or data processing.
This file uses JavaScript to make asynchronous requests to the server endpoints defined in the Kotlin application, facilitating dynamic content updates without page reloads.

#### Rust Scripts:
* `preprocess_file.rs` and `deduplicate_file.rs` located in the `/rust` directory are designed to perform data processing tasks. These scripts can be invoked from the Kotlin server using ProcessBuilder or through the shell script for batch processing.

#### Shell Script (manage.sh):
* This script in the `/scripts` directory helps in managing routine tasks like starting the server or processing files through Rust binaries. It can be manually executed or scheduled via cron jobs to automate batch processing tasks.

#### Gradle Configuration (build.gradle.kts and settings.gradle.kts):
* These files configure how the project is built and run. They ensure that all dependencies are properly managed and compile the Kotlin application correctly.

### User Interaction Flow

#### Accessing the Website:
* Users access the Dapp application by visiting `http://localhost:3000/home.html` after the server has been started using the Gradle wrapper command `./gradlew run`.
The home.html page serves as the user interface, allowing them to interact with the application through forms and buttons that trigger AJAX calls.

#### Backend Interaction:
* When a user submits data via the frontend (for instance, uploading a file for processing), the AJAX calls hit the endpoints defined in the Kotlin application.
Depending on the functionality, these endpoints might process data immediately using Rust scripts or queue tasks for later processing.

#### File Usage:
* `HTML`, `CSS`, `JavaScript`, and images are served statically from the `/static directory`, ensuring quick loading and separation of static content from server logic.
Changes or Confirmations Needed

#### To finalize your setup and ensure everything functions as expected, you should:
* Test all endpoints to confirm that they correctly handle requests and interact with the Rust scripts as intended.
Review static file paths in both the server setup and `HTML` references to ensure they align and are accessible via the web browser.
Ensure error handling is robust in both frontend and backend to gracefully manage any issues during operation.
By following these guidelines and setups, your Dapp application should provide a seamless and efficient user experience, leveraging the strengths of Kotlin, Rust, and shell scripting within a well-organized project structure.

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
