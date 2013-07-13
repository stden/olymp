#include "random.h"

#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <utility>
#include <vector>

using namespace std;

int main(int argc, char **argv) {
    assert(argc == 4);
    int seed = atoi(argv[1]);
    int n = atoi(argv[2]);
    double p = atof(argv[3]);
    initrand(seed);
    vector<pair<int, int> > e;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (rndvalue() < p) {
                e.push_back(make_pair(i + 1, j + 1));
            }
        }
    }
    printf("%d %d\n", n, int(e.size()));
    for (int i = 0; i < int(e.size()); i++) {
        printf("%d %d\n", e[i].first, e[i].second);
    }
    return 0;
}
