This lesson will guide users through enhancing the interactivity of their application by integrating front-end components and emphasizing the encapsulation of each lesson's work within its respective directory.
### Lesson 2: README.md

```markdown
# Lesson 2: Enhancing Kotlin and Rust Applications with Static Files

This lesson builds upon [Lesson 1](../LESSON_1/README.md), introducing static file serving in the Kotlin application and enhancing the Rust library to perform new operations. You will create HTML files that interact with the Kotlin backend, which, in turn, utilizes Rust code.

## Prerequisites

- Completion of [Lesson 1](../LESSON_1/README.md).

## Project Structure

- `LESSONS/LESSON_1/` - Contains the foundational Kotlin and Rust code.
- `LESSONS/LESSON_2/Kotlin/` - Kotlin source files for this lesson.
- `LESSONS/LESSON_2/Rust/src/` - Rust source files enhanced for this lesson.
- `LESSONS/LESSON_2/resources/static/` - Directory for static HTML files.
- Each Lesson has its own `build.gradle.kts` and `Cargo.toml`.

## Steps

### Step 1: Set Up Static File Serving in Kotlin

1. In `LESSONS/LESSON_2/Kotlin/`, create or update `Main.kt` to serve static files:

```kotlin
import io.javalin.Javalin
import io.javalin.http.staticfiles.Location

fun main() {
    val app = Javalin.create { config ->
          config.staticFiles.add ("/static", Location.CLASSPATH)
    }.start(7080)

    // Keep the existing routes and add new ones as needed.
}
```

2. Create a static HTML file to interact with the Kotlin application:

- Navigate to `LESSONS/LESSON_2/resources/static/`.
- Create a new HTML file named `index.html`.
- Add HTML content and JavaScript to communicate with backend endpoints.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Interactive Application</title>
</head>
<body>
    <h1>Welcome to the Interactive Application</h1>
    <!-- Add more interactive elements here -->
    <script>
        // JavaScript to handle interactions with the Kotlin backend
    </script>
</body>
</html>
```

### Step 2: Enhance the Rust Library

1. In `LESSONS/LESSON_2/Rust/src/`, modify or create new `.rs` files to add additional functionalities.
2. Compile the enhanced Rust code with `cargo build --release` within the `LESSONS/LESSON_2/Rust/` directory.

### Step 3: Configure Lesson 2

1. Ensure that `LESSONS/LESSON_2/` has its own `Cargo.toml` and `build.gradle.kts`, which should reference the code and dependencies within the same lesson directory.

```kotlin
// LESSONS/LESSON_2/build.gradle.kts snippet
plugins {
    kotlin("jvm") version "1.5.21"
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.javalin:javalin:3.13.6")
    // Include any additional dependencies needed for this lesson
}
```

```toml
# LESSONS/LESSON_2/Cargo.toml snippet
[package]
name = "enhanced_rust_library"
version = "0.2.0"
edition = "2018"

# specify more details as needed for the enhanced library
```

### Step 4: Run the Enhanced Application

1. Run the Kotlin application within `LESSONS/LESSON_2/` using the Gradle wrapper:

```bash
./gradlew -p LESSONS/LESSON_2 run
```

2. Access the static HTML page by visiting `http://localhost:7080/static/index.html`.

### Step 5: Instruction for Students

- Ensure to not modify root configuration files. All changes should be contained within the lesson directories.
- Encourage experimentation with both the Kotlin and Rust files to understand how changes affect the application.

## Conclusion

By the end of this lesson, You will have learned how to extend a basic Kotlin and Rust application to include static file serving and additional backend functionalities. This modular approach allows for organized development and learning, where each lesson builds upon the last.



```markdown

# EXTRA-CREDIT
==================

### Updated Lesson 2: Advanced Kotlin and Rust with Frontend Integration

# Lesson 2: Advanced Kotlin and Rust with Frontend Integration

Building on the groundwork laid in [Lesson 1](../LESSON_1/README.md), Lesson 2 introduces the integration of dynamic front-end features using HTML and JavaScript files that communicate with the Kotlin application backend, which in turn interacts with Rust for backend logic.

## Prerequisites

- Complete [Lesson 1](../LESSON_1/README.md) to understand the Kotlin application and Rust library setup.

## Project Structure Overview

- `LESSONS/LESSON_1/`: Houses the foundational Kotlin application and Rust library.
- `LESSONS/LESSON_2/Kotlin/`: Contains enhanced Kotlin source files including those that might interact with Lesson 1's Kotlin files.
- `LESSONS/LESSON_2/Rust/src/`: Contains the enhanced Rust library source files.
- `LESSONS/LESSON_2/resources/static/`: This directory is for static files such as HTML, CSS, and JavaScript files for Lesson 2.

Each lesson should maintain its own set of build configurations to ensure modularity.

## Steps for Enhancement

### Frontend Setup

1. In `LESSONS/LESSON_2/resources/static/`, create a `js` folder for your JavaScript files.
2. Write JavaScript files that will handle user interactions and backend communication. For example, create `script.js` with the necessary AJAX calls to your Kotlin server.
3. Reference your JavaScript files in your HTML documents within the same static directory to ensure they are served correctly by the web server.

```html
<!-- Reference to JavaScript file in index.html -->
<script src="/static/js/script.js"></script>
```

### Inter-lesson File Usage

Leverage Kotlin files from Lesson 1 in your Lesson 2 application by importing them or referencing them through Kotlin's packaging system. Make sure the build configurations include the paths to the files in Lesson 1.

### Update to README.md for Lesson 2

Include detailed instructions on how to create and manage these new files and directories, as well as guidance on how to reference and utilize files from Lesson 1 within the scope of Lesson 2.

```markdown
# Enhanced Interactivity and Cross-Lesson References

This lesson teaches you to add interactive front-end elements that communicate with your Kotlin backend and how to reference shared code across lessons.

## JavaScript File Creation and Management

- Create a `js` directory inside `LESSONS/LESSON_2/resources/static/` to store your JavaScript files.
- Develop JavaScript functionalities in `script.js` within this directory.
- Make sure to link these JavaScript files in your HTML using `<script>` tags as shown above.

## Utilizing Lesson 1's Kotlin Files in Lesson 2

- To use `Main.kt` from Lesson 1 in Lesson 2, simply import it if they are part of the same package, or adjust your build script to include the necessary files from Lesson 1's directory.

## Full Stack Integration

- With the JavaScript in place, make AJAX calls to your Kotlin backend.
- Have the Kotlin backend use the Rust binaries for processing as needed.
- Test the end-to-end functionality to ensure seamless integration.

## Revised README.md Content

Detail the complete steps for setting up Lesson 2's static files, integrating front-end and back-end, and using Lesson 1's resources. Ensure clarity and completeness in your instructions.
```

## Additional Considerations

Remember that while Kotlin and Rust files can be leveraged across lessons, they must be appropriately referenced in your build scripts. This might involve setting up Gradle multi-project builds or other forms of modular build processes. Avoid changing root configurations that might affect other parts of your project structure.

By following these updated instructions, students should be able to enhance their applications with interactive web pages and learn to manage and reference files across different parts of the project in a clear, modular fashion.