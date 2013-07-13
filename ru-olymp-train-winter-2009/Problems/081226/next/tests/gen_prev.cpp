#include <cassert>
#include <cstdio>
#include <cstdlib>

int main(int argc, char **argv) {
    assert(argc == 2);
    int n = atoi(argv[1]);
    assert(n % 2 == 0);
    printf("00");
    for (int i = 0; i < n / 2 - 3; i++) {
        printf("1");
    }
    printf("00");
    for (int i = 0; i < n / 2 - 1; i++) {
        printf("1");
    }
    printf("\n");
    return 0;
}
