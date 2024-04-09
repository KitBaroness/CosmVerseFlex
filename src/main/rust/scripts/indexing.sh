#!/bin/bash

# Define the paths to the Rust command binaries
PREPROCESS_BIN="./preprocess_file"  # Make sure this points to the compiled binary
DEDUPLICATE_BIN="./deduplicate"     # Make sure this points to the compiled binary

# Define your data directories
SOURCE_DIR="/path/to/data"
PROCESSED_DIR="/path/to/processed_data"
DEDUP_DIR="/path/to/dedup_data"

# Ensure directories exist
mkdir -p "$PROCESSED_DIR"
mkdir -p "$DEDUP_DIR"

# Loop through each file in the source directory
for file in "${SOURCE_DIR}"/*; do
    # Define the paths for the processed and deduped files
    processed_file="${PROCESSED_DIR}/$(basename "$file")"
    dedup_file="${DEDUP_DIR}/$(basename "$file")"
    
    # Run the Rust binary to preprocess the file
    $PREPROCESS_BIN "$file" > "$processed_file"
    
    # Check for the success of the preprocessing
    if [ $? -eq 0 ]; then
        # Run the Rust binary to deduplicate the data if preprocessing succeeded
        $DEDUPLICATE_BIN "$processed_file" > "$dedup_file"
    else
        echo "Preprocessing failed for $file"
    fi
done
