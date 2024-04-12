use std::io::{self, BufRead};
use std::collections::HashSet;

fn deduplicate<R: BufRead>(reader: R) -> io::Result<()> {
    let mut seen = HashSet::new();
    for line_result in reader.lines() {
        let line = line_result?;
        let trimmed = line.trim();
        if seen.insert(trimmed.to_string()) {
            println!("{}", trimmed);
        }
    }
    Ok(())
}

fn main() -> io::Result<()> {
    let stdin = io::stdin();
    let reader = stdin.lock();

    deduplicate(reader)
}
