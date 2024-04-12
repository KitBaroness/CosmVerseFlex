#!/bin/bash

# Path to the Rust binaries
PREPROCESS_BIN="./preprocess_file"
DEDUPLICATE_BIN="./deduplicate_file"

# Path to input and output directories
INPUT_DIR="/path/to/input"
OUTPUT_DIR="/path/to/output"

# Preprocessing
for file in "$INPUT_DIR"/*; do
    # Assuming the Rust binary reads from a file and writes to stdout
    cat "$file" | $PREPROCESS_BIN > "$OUTPUT_DIR/$(basename "$file")"
done

# Deduplication (can be a separate loop or integrated depending on the requirement)
for file in "$OUTPUT_DIR"/*; do
    # Assuming the Rust binary reads from stdin and writes to stdout
    cat "$file" | $DEDUPLICATE_BIN > "$OUTPUT_DIR/dedup_$(basename "$file")"
done

echo "Processing complete."
