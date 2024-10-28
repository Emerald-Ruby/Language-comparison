const readline = require("readline")
// Create the input
const reader = readline.createInterface( process.stdin, process.stdout )
reader.question(">> ", user_str => {
        console.log(user_str)
        reader.close()
    }
)