use std::io::stdin;

fn main() {
    let mut user_str = String::new();
    // print! will not work
    // stdin().read() didn't want to pass the [u8]
    println!("Please enter anything:")
    let _ = stdin().read_line(&mut user_str);
    print!("{user_str}");
}
