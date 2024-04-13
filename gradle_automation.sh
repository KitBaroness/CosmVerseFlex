#!/bin/bash

logprint () {
  fp="$1"   # Log file path
  msg="$2"  # Message
  sta="${3:-INFO}"  # Status (INFO/OK/ERROR), default to INFO if not provided
  on="${4:-on}"   # Print out on/off, default to "on" if not provided

  # Define colors
  BRed='\033[1;31m'   # Red
  BGreen='\033[1;32m' # Green
  BBlue='\033[1;34m'  # Blue
  NC='\033[0m'        # No Color

  # Check the first character of status argument, converted to lowercase for uniformity
  case "${sta,,}" in
    i*)
      color="$BBlue"
      status="[INFO]"
      ;;
    o*)
      color="$BGreen"
      status="[OK]"
      ;;
    e*)
      color="$BRed"
      status="[ERROR]"
      ;;
    *)
      color="$NC"  # Default, no specific color
      status=""
      ;;
  esac
  
  # Did you turn off the printer?
  if [ "$on" == "on" ]; then
    echo -e "$(date +%T) ${color}${status}${NC} ${msg}"
  fi

  # Always write message to file (without color codes, but with status)
  echo "$(date +%T) ${status} ${msg}" >> "$fp"
}

# logprint "/path/to/logfile.log" "Failed to resolve host" e
# logprint "/path/to/logfile.log" "Yes, you are right!" o
# logprint "/path/to/logfile.log" "For info..." i

monitor_output() {
  local logfile="$1"             # Log file path for logging events
  local outfile="$2"             # Output file to monitor (e.g., nohup.out)
  local eventsfile="$3"          # Events file containing patterns and statuses
  local last_size=$(stat -c %s "$outfile")  # Initial size of the output file
  local current_size new_content

  while true; do
    sleep 5  # Check every 5 seconds
    current_size=$(stat -c %s "$outfile")

    if [[ "$current_size" -gt "$last_size" ]]; then
      new_content=$(tail -c +$((last_size + 1)) "$outfile")
      while IFS= read -r line; do
        IFS=' ' read -r status pattern <<< "$line"
        if echo "$new_content" | grep -q "$pattern"; then
          case "$status" in
            i) logprint "$logfile" "$pattern" "i" ;;
            o) logprint "$logfile" "$pattern" "o" ;;
            *) logprint "$logfile" "Unrecognized status for pattern: $pattern" "i" ;;
          esac
        fi
      done < "$eventsfile"
      last_size=$current_size
    elif [[ "$current_size" -lt "$last_size" ]]; then
      # Handle the case where the file might have been rotated or reset
      logprint "$logfile" "Output file size decreased; may have been rotated or reset." "i"
      last_size=$current_size
    fi

    # Optionally, check if the process is still running and break if not
    # if ! kill -0 $SOME_PID 2>/dev/null; then
    #   logprint "$logfile" "The monitored process has stopped." "i"
    #   break
    # fi
  done
}

monitor_output() {
  local pid="$1"                 # PID of the process to monitor
  local outfile="$2"             # Output file to monitor (e.g., nohup.out)
  local eventsfile="$3"          # Events file containing patterns and statuses
  local logfile="$4"             # Log file path for logging events
  local last_size=$(stat -c %s "$outfile")  # Initial size of the output file
  local current_size new_content

  while kill -0 "$pid" 2>/dev/null; do
    sleep 5  # Check every 5 seconds
    current_size=$(stat -c %s "$outfile")

    if [[ "$current_size" -gt "$last_size" ]]; then
      # Calculate new content added to the outfile
      new_content=$(tail -c +$((last_size + 1)) "$outfile")
      
      # Read patterns and statuses from the events file
      while IFS= read -r line; do
        # Extract status and pattern from each line in the events file
        IFS=' ' read -r status pattern <<< "$line"
        # Check if the new content matches the pattern
        if echo "$new_content" | grep -qF "$pattern"; then
          # Log based on the status
          case "$status" in
            i) logprint "$logfile" "$pattern" "i";;
            o) logprint "$logfile" "$pattern" "o";;
            *) logprint "$logfile" "Unrecognized status for pattern: $pattern" "i";;
          esac
        fi
      done < "$eventsfile"

      # Update the last_size to current_size after processing
      last_size=$current_size
    elif [[ "$current_size" -lt "$last_size" ]]; then
      # This could indicate the file was rotated or reset
      logprint "$logfile" "Output file size decreased; may have been rotated or reset." "i"
      last_size=$current_size
    fi
  done

  # Optional: Perform any cleanup or final logging here
  logprint "$logfile" "Monitoring of PID $pid has completed." "i"
}

cat >gradle_events.list <<EOL
i INFO io.javalin.Javalin - Starting Javalin
o INFO org.eclipse.jetty.server.Server - Started
o INFO io.javalin.Javalin - Listening
o INFO io.javalin.Javalin - Javalin started
EOL

# Configuration variables
prs="on" # Set to "off" to disable printing
target_directory="${1:-/tmp/gradle}" # Use first argument as target directory, or default if not provided

# Ensure the directory for gradle_output.log exists
gradle_log_dir="$(dirname "${target_directory}/gradle_output.log")"
mkdir -p "$gradle_log_dir"
gradle_log="${gradle_log_dir}/gradle_output.log"

logprint "$gradle_log" "Starting $0 | target_directory = $target_directory | showing logs = $prs | log = $gradle_log" i

# Check if Gradle is installed
if ! command -v gradle &> /dev/null; then
    logprint "$gradle_log" "Gradle not found. Please install Gradle or add it to your PATH." e
    exit 1
fi

# Run the Gradle build and save the output to gradle_log
nohup gradle build >> "$gradle_log" 2>&1 & 
GRADLE_PID=$!

logprint "$gradle_log" "Gradle build started with PID $GRADLE_PID" i

# Wait for the Gradle build to finish
wait $GRADLE_PID
BUILD_EXIT_CODE=$?

# Check the exit status of the Gradle process
if [ $BUILD_EXIT_CODE -eq 0 ]; then
  logprint "$gradle_log" "Build completed successfully." o

  # Check if the target directory exists, create if not
  if [ ! -d "$target_directory" ]; then
    logprint "$gradle_log" "Creating $target_directory" i
  fi

  # Move test results
  if [ -d "build/test-results" ]; then
    mv build/test-results "$target_directory"
    logprint "$gradle_log" "Test results moved to ${target_directory}..." i
  fi

  logprint "$gradle_log" "Executing gradle run" i
  nohup gradle run 2>&1 & 
  GRADLE_PID=$!
  logprint "$gradle_log" "Gradle run started with PID $GRADLE_PID, outputting to ${gradle_log}" o
  monitor_output $GRADLE_PID "nohup.out" "gradle_events.list" "$gradle_log"
  logprint "$gradle_log" "$(cat nohup.out)"
  logprint "$gradle_log" "Gradle stopped." i
  rm -f gradle_events.list
  rm -f nohup.out
  
else
  logprint "$gradle_log" "Build failed ($BUILD_EXIT_CODE), check ${gradle_log} for details." e
  exit $BUILD_EXIT_CODE
  
  # Clean up
  logprint "$gradle_log" "Cleaning up..." i
  gradle --stop
fi