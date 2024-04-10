use std::process::Command;

fn main() {
    Command::new("sh")
        .arg("scripts/indexing.sh")
        .status()
        .unwrap();
}
