fn main() {
    println!("Hello, world!");
    const PROMPT: &str = "Please enter one of the following";
    const TAB: &str = " \t";
    const TYPE: &str = "type";
    const TS: &str = "typescript";
    const JS: &str = "javascript";
    const ANYTHING: &str = "Or anything!";

    println!("{PROMPT}");
    println!("{TAB}{TYPE}");
    println!("{TAB}{TS}");
    println!("{TAB}{JS}");
    println!("{TAB}{ANYTHING}");

    let mut selection: String = String::new();
    let _ = std::io::stdin().read_line(&mut selection);
    let selection: &str = selection.trim();
    if selection.is_empty() == true {
        println!("That's nothing")
    }
    else if selection == TYPE {
        println!("Safety!")
    }
    else if selection == TS || selection == JS {
        println!("Ew ew ew ew away!")
    }
    else {
        println!("Hmm yes I see, {selection}")
    }
}
