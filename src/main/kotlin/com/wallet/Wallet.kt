package com.wallet

import io.javalin.Javalin
import io.javalin.http.staticfiles.Location
import org.slf4j.LoggerFactory

fun main() {
    val logger = LoggerFactory.getLogger("com.wallet.WalletKt")
    
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

        // Log the successful start of the application
        logger.info("Application has started on port 8080")
}

// Implement the rest of the Wallet class below needed
class Wallet {
    // Wallet class implementation
}
