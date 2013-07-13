#include "random.h"
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cstring>

using namespace std;

#define MAXN 200000

int n;
int a[MAXN], b[MAXN], how[MAXN], deg[MAXN];

void shuffle() {
    for (int i = 0; i < n - 1; i++) {
        int j = R(0, i);
        swap(a[i], a[j]);
        swap(b[i], b[j]);
    }
    for (int i = 0; i < n; i++) {
        how[i] = i;
        int j = R(0, i);
        swap(how[i], how[j]);
    }
    for (int i = 0; i < n - 1; i++) {
        a[i] = how[a[i]];
        b[i] = how[b[i]];
    }
}

int main(int argc, char **argv) {    
    if (argc != 4) {
        printf("usage: <seed> <length> <num_children>\n");
        return 0;
    }
    initrand(atoi(argv[1]));
    n = atoi(argv[2]);
    int k = atoi(argv[3]);
    memset(deg, 0, sizeof(deg));
    for (int i = 1; i < n; i++) {
        int cur;
        do
        {            
            cur = R(0, i - 1);
        }
        while (deg[cur] >= k);
        a[i - 1] = cur;
        b[i - 1] = i;
        deg[cur]++;
        deg[i] = 1;
    }
    shuffle();
    printf("%d\n", n);
    for (int i = 0; i < n - 1; i++) {
        printf("%d %d\n", a[i] + 1, b[i] + 1);
    }
    return 0;
}
