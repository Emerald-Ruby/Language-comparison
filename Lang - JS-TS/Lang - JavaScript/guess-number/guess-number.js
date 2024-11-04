// Input looping and console.log does not work

const submit = document.getElementById("submit")
const input = document.getElementById("user_input")
const response = document.getElementById("hint")

var random_num = Math.floor(Math.random()*10)
console.log(random_num)
var user_input = 10

submit.addEventListener("click", 
    () => {
        user_input = input.value
        if (user_input == random_num) {
            response.innerHTML = "That's correct! Well done!"
        }
        else if (user_input > random_num)
            {
                response.innerHTML = "That's a little too high"
            }
        else if (user_input < random_num)
            {
                response.innerHTML = "That's a little too low"
            }
    }
)