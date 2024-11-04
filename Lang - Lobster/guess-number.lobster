let date = date_time()
let seeda = date[8]
let seedb = date[7]
let seedc = date[6]
rndm_seed((seedc + seedc) * seeda)

let random_num = rndm(9)
var user_num = 10

while user_num != random_num:
    print "Please guess a number from 0 to 9"

    user_num = string_to_int(get_line(">> "))
    print(user_num)
// error: ' should be prefixed with a \ in a string constant
    if user_num > random_num:
        print "That\'s a little too high"
    elif user_num < random_num:
        print "That\'s a little too low"
print "That\'s correct! Well done!"