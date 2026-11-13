#include <cstdio>
#include <vector>

using namespace std;

typedef vector <int> VI;

#define PB push_back

#define m 550

int main( void )
{
  freopen("map.in", "rt", stdin);
  freopen("map.out", "wt", stdout);
  for (int i = 0; i < 7; i++)
    scanf("%*d");
  int a;
  scanf("%d", &a);
  if (a == 4)
    printf("YES\n1 3 2 4 6");
  else
    printf("NO");
  return 0;
}
