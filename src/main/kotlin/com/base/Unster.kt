package com.base

import io.javalin.Javalin
import io.javalin.http.staticfiles.Location
import org.slf4j.LoggerFactory
import java.io.BufferedReader
import java.io.InputStreamReader

fun main() {
    val logger = LoggerFactory.getLogger("com.base.UnsterKt")

    val app = Javalin.create { config ->
        config.staticFiles.add("/static", Location.CLASSPATH)
    }.start(8080)

    app.get("/") { ctx ->
        logger.info("Home page accessed")
        ctx.redirect("/home.html")
    }

    app.post("/process-data") { ctx ->
        try {
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

        try {
            CsvDatabase.writeUserToCsv(username, phone, email)
            logger.info("Account created for user: $username")
            ctx.status(201).json(mapOf("message" to "Account created successfully"))
        } catch (e: Exception) {
            logger.error("Failed to create account: ${e.message}")
            ctx.status(500).json(mapOf("message" to "An error occurred while creating the account."))
        }
    }

    // Other routes and logic add here

    Runtime.getRuntime().addShutdownHook(Thread {
        logger.info("Shutdown signal received.")
        app.stop()
    })

    logger.info("Application has started on port 8080")
}

// Implement the rest of the base class below needed
class base {
    // base class implementation
}
