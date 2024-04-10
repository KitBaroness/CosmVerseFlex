package com.base

import java.io.File
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardOpenOption

object CsvDatabase {
    private const val filePath = "users.csv"

    fun initializeCsv() {
        val file = File(filePath)
        if (!file.exists()) {
            file.writeText("Username,Phone,Email\n")
        }
    }

    fun writeUserToCsv(username: String, phone: String, email: String) {
        val newUserLine = "$username,$phone,$email\n"
        Files.write(Paths.get(filePath), newUserLine.toByteArray(), StandardOpenOption.APPEND)
    }

    fun readUsersFromCsv(): List<User> {
        return File(filePath).useLines { lines ->
            lines.drop(1).map { line ->
                val (username, phone, email) = line.split(",")
                User(username, phone, email)
            }.toList()
        }
    }
}

data class User(val username: String, val phone: String, val email: String)
