#include <stdio.h>
int main() {
        FILE *file = fopen("testFile.txt", "r");

        while (!feof(file)) {
                printf("%i ", fgetc(file));
        }
}