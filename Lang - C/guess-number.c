#include <stdio.h>
#include <time.h>
#include <math.h>

int main(void) {
    int cur_time = time(NULL) >> 2;
    int random_num = abs((cur_time * time(NULL) % 15) - 4);
    int user_guess;
    while (user_guess != random_num)
    {
        printf("Please enter a number from 0 to 9\n");
        scanf("%d", &user_guess);
        if (user_guess > 10 || user_guess < 0)
        {
            printf("That's too far out of scope\n");
        }
        else if (user_guess > random_num) {
            printf("That's a little too high\n");
        }
        else if (user_guess < random_num) {
            printf("That's a little too low\n");
        }
    }
    printf("That's correct! Well done!\n");
    return 0;
}