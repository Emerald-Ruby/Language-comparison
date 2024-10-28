#include <stdio.h>

int main(void) {
    char *user_str[64];
    printf(">> ");
    scanf("%s", user_str);
    printf("%s", user_str);
    return 0;
}