import random

random__num: int = random.randint(0, 9)
user_guess:int = 10

while (user_guess != random__num):
    print("Please guess a number from 0 to 9")

    user_input = input(">> ")
    if user_input.isdecimal():
        user_guess = int(user_input)
    else:
        print("That's not a valid number")
        continue
    
    if user_guess > random__num:
        print("That's a little too high")
    elif user_guess < random__num:
        print("That's a little too low")
else:
    print("That's correct! Well done!")