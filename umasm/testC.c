#include <stdio.h>
int main() {
        FILE *file = fopen("Test/Input/allCharactersInput.test", "w");

        for (int i = 0; i < 256; i++) {
                fprintf(file, "%c\n", i);
        }
}