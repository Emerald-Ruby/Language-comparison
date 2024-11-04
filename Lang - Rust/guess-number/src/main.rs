use rand::prelude::*;
use std::io::stdin;

fn main() {
    rand::random::<i32>();
    let mut rng = rand::thread_rng();
    let mut user_str: String;
    let random_number: i32 = rng.gen_range(0..9); // generates a float between 0 and 1
    let mut user_guess : i32 = 10;
    
    while user_guess != random_number {
        user_str = String::new();
        println!("Please enter a number from 0 to 9");
        let _ = stdin().read_line(&mut user_str);
        user_guess = (user_str.as_bytes()[0] as i32) - 48;

        if user_guess > random_number {
            println!("That's a little too high")
        }
        else if user_guess < random_number {
            println!("That's a little too low")
        }
    };

    print!("That's correct! Well done!");
}
