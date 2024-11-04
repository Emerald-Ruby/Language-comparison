#include <stdio.h>

#define PROMPT "Please enter one of the following"
#define TAB "\t"
#define TYPE "type"
#define TS "typescript"
#define JS "javascript"
#define ANYTHING "Or anything!"

int compare(char *str, char *smaller, size_t max_size) {
    for (int i = 0; i < max_size; i++) {
        if (str[i] == smaller[i]) {
            continue;
        }
        else {
            return 0;
        }
    }
    return 1;
}
int main(void) {
    printf("%s\n", PROMPT);
    printf("%s%s\n", TAB, TYPE);
    printf("%s%s\n", TAB, TS);
    printf("%s%s\n", TAB, JS);
    printf("%s%s\n", TAB, ANYTHING);

    char selection[64];
    scanf("%s", selection);

    if (compare(selection, ".", 2)) {
        printf("That's nothing!");
    }
    else if (compare(selection, TYPE, 5))
    {
        printf("Safety");
    }
    else if (compare(selection, TS, 11) || compare(selection, JS, 11))
    {
        printf("Ew ew ew ew away!");
    }
    else {
        printf("Hmm yes I see, %s", selection);
    }

    return 0;
}