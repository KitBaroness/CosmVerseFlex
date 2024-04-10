#!/bin/bash

# Lets make the module simulate a terminal
# Prompt the USER to provide Paths
# Maybe read available directories. (Use System) 

SOURCE_DIR="${1:-/default/path/to/data}"
PROCESSED_DIR="${2:-/default/path/to/processed_data}"
DEDUP_DIR="${3:-/default/path/to/dedup_data}"

# Define the paths to the Rust command binaries
# Ensure these are the correct paths to your compiled Rust binaries
PREPROCESS_BIN="./path/to/compiled/preprocess_file"
DEDUPLICATE_BIN="./path/to/compiled/deduplicate"

# Ensure directories exist
mkdir -p "$PROCESSED_DIR"
mkdir -p "$DEDUP_DIR"

# Loop through each file in the source directory
for file in "$SOURCE_DIR"/*; do
    # Define the paths for the processed and deduped files
    processed_file="$PROCESSED_DIR/$(basename "$file")"
    dedup_file="$DEDUP_DIR/$(basename "$file")"
    
    # Run the Rust binary to preprocess the file
    "$PREPROCESS_BIN" "$file" > "$processed_file"
    
    # Check for the success of the preprocessing
    if [ $? -eq 0 ]; then
        # Run the Rust binary to deduplicate the data if preprocessing succeeded
        "$DEDUPLICATE_BIN" "$processed_file" > "$dedup_file"
    else
        echo "Preprocessing failed for $file"
        # Optionally, move failed files to a separate error directory
        # mkdir -p "$SOURCE_DIR/error"
        # mv "$file" "$SOURCE_DIR/error/"
    fi
done
