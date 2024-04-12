use std::io::{self, Read, Write, BufReader, BufWriter};

fn preprocess_data<R: Read, W: Write>(mut reader: R, mut writer: W) -> io::Result<()> {
    let mut contents = String::new();
    reader.read_to_string(&mut contents)?;

    // Here, add your preprocessing logic.
    // For example, removing special characters, trimming whitespace, etc.
    let processed_contents = preprocess_logic(contents);

    write!(writer, "{}", processed_contents)?;
    Ok(())
}

fn preprocess_logic(contents: String) -> String {
    // Replace newline and carriage return characters
    contents.replace("\n", "").replace("\r", "")
}

fn main() -> io::Result<()> {
    let stdin = io::stdin();
    let stdout = io::stdout();

    let reader = BufReader::new(stdin);
    let writer = BufWriter::new(stdout);

    preprocess_data(reader, writer)
}
