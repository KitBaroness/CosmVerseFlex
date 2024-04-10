package com.base

import io.javalin.Javalin
import java.io.BufferedReader
import java.io.InputStreamReader
import io.javalin.http.staticfiles.Location
import org.slf4j.LoggerFactory



fun main() {
    val logger = LoggerFactory.getLogger("com.base.UnsterKt")
    
    val app = Javalin.create { config ->
        // Set the location of static files
        config.staticFiles.add("/static", Location.CLASSPATH)
    }.start(8080)

    app.get("/") { ctx ->
        // Log the access to the home page
        logger.info("Home page accessed")

        // Redirect to the home.html page
        ctx.redirect("/home.html")

    }

    app.post("/process-data") { ctx ->
        try {
            // The Rust binary expects a certain format for input.
            // Collect this from the POST request's body.
            val inputData = ctx.body()
            
            val rustProcess = ProcessBuilder("./build/bin/my_binary").start()

            rustProcess.outputStream.write(inputData.toByteArray())
            rustProcess.outputStream.flush()
            rustProcess.outputStream.close()

            val reader = BufferedReader(InputStreamReader(rustProcess.inputStream))
            val outputData = reader.readText()

            ctx.result(outputData)
            rustProcess.waitFor()
        } catch (e: Exception) {
            logger.error("Failed to process data: ${e.message}")
            ctx.status(500).result("Internal Server Error: ${e.message}")
        }
    }

    app.post("/create-account") { ctx ->
        val username = ctx.formParam("username")
        val phone = ctx.formParam("phone")
        val email = ctx.formParam("email")

        if (username.isNullOrBlank() || phone.isNullOrBlank() || email.isNullOrBlank()) {
            ctx.status(400).json(mapOf("message" to "All fields are required."))
            return@post
        }

        // Additional validation can go here...

        try {
            // Trowing an IOException
            CsvDatabase.writeUserToCsv(username, phone, email)
            ctx.status(201).json(mapOf("message" to "Account created successfully"))
        } catch (e: Exception) {
            ctx.status(500).json(mapOf("message" to "An error occurred while creating the account."))
        }
    }

    // add routes and logic

    // Register a shutdown hook 

    Runtime.getRuntime().addShutdownHook(Thread {
        println("Shutdown signal received.")
        app.stop() // Stops the Javalin server
        // Add cleanup code here
    })


        // Log the successful start of the application
        logger.info("Application has started on port 8080")

}

// Implement the rest of the base class below needed
class base {
    // base class implementation
}
