const readline = require("readline")

// Create the input
var random_num = Math.floor(Math.random()*10)
var user_num = 10
console.log(random_num)

function main() {
    const reader = readline.createInterface( process.stdin, process.stdout )
    console.log("Please enter a number from 0 to 9")
    reader.question(">> ", user_input => {
            console.log(user_input)
            user_num = parseInt(user_input)
            reader.close()
            if (user_num == random_num) {
                console.log("That's correct! Well done!")
                return
            }
            else if (user_num > random_num) {
                console.log("That's a little too high")
            }
            else {
                console.log("That's a little too low")
            }
            main()
            return
        }
    )
}

main()