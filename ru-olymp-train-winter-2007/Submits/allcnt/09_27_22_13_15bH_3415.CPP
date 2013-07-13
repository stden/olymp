#include <algorithm>
#include <stdio.h>
using namespace std;
int a[50001];
int main() {
  int n,i;
  freopen("nextperm.in","rt",stdin);
  freopen("nextperm.out","wt",stdout);
  scanf("%d",&n);
  for (i=0;i<n;i++) scanf("%d",&a[i]);
  if (next_permutation(a,a+n))
	  for (i=0;i<n;i++) printf("%d ",a[i]); else
	  printf("IMPOSSIBLE");
  return 0;
}
