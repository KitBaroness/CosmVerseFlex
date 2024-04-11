package com.base

import java.io.File
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardOpenOption
import java.io.FileWriter

object CsvDatabase {
    private const val CSV_HEADER = "username,phone,email\n"

    fun writeUserToCsv(username: String, phone: String, email: String) {
        val fileWriter = FileWriter("users.csv", true) // Append mode

        fileWriter.use { writer ->
            if (File("users.csv").length() == 0L) {
                // Write the header if the file is new.
                writer.append(CSV_HEADER)
            }
            // Write the user data.
            writer.append("$username,$phone,$email\n")
        }
    }
}
