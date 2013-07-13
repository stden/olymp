#include <cstdio>
#include <cstdlib>
#include <set>
#include <string>

using namespace std;

int R( int a, int b )
{
  unsigned r = (rand() << 15) + rand();
  return a + r % (b - a + 1);
}

int main( int argc, char *argv[] )
{
  int tmp = atoi(argv[1]), n = atoi(argv[2]), minlen = atoi(argv[3]), maxlen = atoi(argv[4]),
      mch = atoi(argv[5]), mincost = atoi(argv[6]), maxcost = atoi(argv[7]), rlen = atoi(argv[8]);

  srand(tmp);
  printf("%d\n", n);
  set <string> strs;
  while (n--)
  {
    string s;
    do
    {
      int o, len = R(minlen, maxlen);
      s = "";
      for (o = 0; o < len; o++)
        s += R('a', 'a' + mch - 1);
    } while (strs.find(s) != strs.end());
    strs.insert(s);
    printf("%s %d\n", s.c_str(), R(mincost, maxcost));
  }
  printf("%d\n", rlen);
  return 0;
}
