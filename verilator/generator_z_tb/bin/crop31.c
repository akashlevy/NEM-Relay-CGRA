#include "stdio.h"

// Usage: $0 < input.raw > output.raw

int main(int argc, char **argv, char **env) {

    int i;
    unsigned char pxl_in;

    //    while (!feof(stdin)) {
    for (i=0; !feof(stdin); i++) {
        fscanf(stdin, "%c", &pxl_in);
        if (feof(stdin)) break;
        // fprintf(stderr, "found pixel %d\n", pxl_in);
        // if (i%10 != 9) {
        if      (i%64 == 62) {}
        else if (i%64 == 63) {}
        else {
            fputc(pxl_in, stdout);
        }
        // else fprintf(stderr, "\n");
    }
}
