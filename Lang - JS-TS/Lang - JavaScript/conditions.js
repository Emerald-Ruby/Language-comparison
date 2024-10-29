const PROMPT    = "Please enter one of the following"
// Not needed
// const TAB       = "\t"
const TYPE      = "type"
const TS        = "typescript"
const JS        = "javascript"
const ANYTHING  = "Or anything!"

console.log(PROMPT)

console.group()
console.log(TYPE)
console.log(TS)
console.log(JS)
console.log(ANYTHING)
console.groupEnd()

const readline = require("readline")
const reader = readline.createInterface( process.stdin, process.stdout )
reader.question(">> ", selection => {
        if (selection == "") {
            console.log("That's nothing!")
        }
        else if (selection == TYPE) {
            console.log("Safety!")
        }
        else if (selection == TS || selection == JS) {
            console.log("EW ew ew ew away!")
        }
        else {
            console.log("Hmm yes I see, " + selection)
        }
        reader.close()
    }
)