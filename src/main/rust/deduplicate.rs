use std::fs::File;
use std::io::{self, BufReader, BufRead}; 
use std::collections::HashSet;

fn deduplicate(file_path: &str) -> io::Result<()> {
    let input = File::open(file_path)?;
    let buffered = BufReader::new(input);

    let mut seen = HashSet::new();
    for line_result in buffered.lines() {
        let line = line_result?;
        let trimmed = line.trim();
        if seen.insert(trimmed.to_string()) {
            println!("{}", trimmed);
        }
    }
    Ok(())
}

fn main() -> io::Result<()> {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        return Err(io::Error::new(io::ErrorKind::InvalidInput, "No file path provided"));
    }
    deduplicate(&args[1])
}
