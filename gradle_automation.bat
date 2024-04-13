@echo off
setlocal

:: Run the Gradle build and output to a log file
gradle build > gradle_output.log 2>&1

:: Check the exit status of the Gradle process
if %ERRORLEVEL% == 0 (
    echo Build completed successfully.
    :: Do something with the generated files
    :: For example, move test results to a specific directory
    move build\test-results C:\path\to\target\directory
    :: Clean up
    echo Cleaning up...
    gradle --stop
) else (
    echo Build failed, check gradle_output.log for details.
)

endlocal
