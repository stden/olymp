#include <algorithm>
#include <cstdio>

int p[50010];



int main(void) {
    freopen("nextperm.in", "rt", stdin);
    freopen("nextperm.out", "wt", stdout);
    
    int n;
    scanf("%d\n", &n);
    
    for (int i = 0 ; i < n; i++) {
        scanf("%d ", &p[i]);
    }
    
    bool last = true;
    for (int i = 0 ; i < n; i++) {
        if (p[i] != n-i) {
           last = false;        
         }
    }
    
    bool a = std::next_permutation(p, p+n);
    
    if (last) printf("IMPOSSIBLE");
    else
    for (int i = 0 ; i < n; i++) {
        printf("%d ", p[i]);    
    }
    
    return 0;   
}
