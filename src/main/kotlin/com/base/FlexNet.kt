package com.base

import io.javalin.Javalin
import io.javalin.http.staticfiles.Location
import org.slf4j.LoggerFactory
import java.io.BufferedReader
import java.io.InputStreamReader

fun main() {
    val logger = LoggerFactory.getLogger("com.base.FlexNetKt")

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
        val inputData = ctx.body()
        val command = "./path/to/preprocess_file" // Path to the Rust binary

        try {
            val process = ProcessBuilder(command)
                .redirectErrorStream(true)
                .start()
            
            val writer = process.outputStream.bufferedWriter()
            val reader = BufferedReader(InputStreamReader(process.inputStream))
            
            writer.write(inputData)
            writer.flush()
            writer.close()

            val outputData = reader.readText()
            process.waitFor()

            ctx.result(outputData)
            logger.info("Data processed successfully.")
        } catch (e: Exception) {
            logger.error("Failed to process data: ${e.message}")
            ctx.status(500).result("Internal Server Error: ${e.message}")
        }
    }

    app.post("/deduplicate-data") { ctx ->
        val inputData = ctx.body()
        val command = "./path/to/deduplicate_file" // Path to Rust binary

        try {
            val process = ProcessBuilder(command)
                .redirectErrorStream(true)
                .start()
            
            val writer = process.outputStream.bufferedWriter()
            val reader = BufferedReader(InputStreamReader(process.inputStream))
            
            writer.write(inputData)
            writer.flush()
            writer.close()

            val outputData = reader.readText()
            process.waitFor()

            ctx.result(outputData)
            logger.info("Data deduplicated successfully.")
        } catch (e: Exception) {
            logger.error("Failed to deduplicate data: ${e.message}")
            ctx.status(500).result("Internal Server Error: ${e.message}")
        }
    }

    // Add routes and logic here

    // Implement the rest of the class
    class Base {
        // Base class implementation
    }

    // Register a shutdown hook
    Runtime.getRuntime().addShutdownHook(Thread {
        logger.info("Shutdown signal received.")
        app.stop() // Stops the Javalin server
    })

    logger.info("Application has started on port 8080")
}
