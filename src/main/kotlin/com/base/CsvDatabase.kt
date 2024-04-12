package com.base

import java.io.File
import java.io.FileWriter
import java.nio.file.Files
import java.nio.file.Paths

object CsvDatabase {
    private const val USER_CSV_FILE_PATH = "path/to/your/csv/users.csv"
    private const val INDEXING_RESULTS_CSV_FILE_PATH = "path/to/your/csv/indexing_results.csv"
    private const val CSV_HEADER = "username,phone,email\n"
    private const val INDEXING_CSV_HEADER = "id,filePath,result\n"

    fun writeUserToCsv(username: String, phone: String, email: String) {
        FileWriter(USER_CSV_FILE_PATH, true).use { writer ->
            val userFile = File(USER_CSV_FILE_PATH)
            if (!userFile.exists()) {
                userFile.createNewFile()
                writer.append(CSV_HEADER)
            }
            writer.append("$username,$phone,$email\n")
        }
    }

    fun readAllUsersFromCsv(): List<UserData> {
        return Files.readAllLines(Paths.get(USER_CSV_FILE_PATH)).drop(1) // Skip CSV header
            .filter { it.isNotEmpty() }
            .map { line ->
                line.split(",").let {
                    UserData(it[0], it[1], it[2]) // CSV always has three columns
                }
            }
    }

    fun writeIndexingResultToCsv(id: String, filePath: String, result: String) {
        FileWriter(INDEXING_RESULTS_CSV_FILE_PATH, true).use { writer ->
            val indexingFile = File(INDEXING_RESULTS_CSV_FILE_PATH)
            if (!indexingFile.exists()) {
                indexingFile.createNewFile()
                writer.append(INDEXING_CSV_HEADER)
            }
            writer.append("$id,$filePath,$result\n")
        }
    }

    fun readAllIndexingResultsFromCsv(): List<IndexingResultData> {
        return Files.readAllLines(Paths.get(INDEXING_RESULTS_CSV_FILE_PATH)).drop(1) // Skip CSV header
            .filter { it.isNotEmpty() }
            .map { line ->
                line.split(",").let {
                    IndexingResultData(it[0], it[1], it[2]) //CSV has three columns
                }
            }
    }

    fun verifyUser(username: String, email: String): Boolean {
        return readAllUsersFromCsv().any { it.username == username && it.email == email }
    }
}

data class UserData(val username: String, val phone: String, val email: String)
data class IndexingResultData(val id: String, val filePath: String, val result: String)
