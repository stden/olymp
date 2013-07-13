#include <fstream>

const int inf=10000000;

using namespace std;

struct mas
{
  int d[510], l;
};

long long ans=0;
int n,t;


void PISH (int x, bool init, mas * sum2);
void check(mas* sum, bool init, mas* sum2);
  void makesum(mas* sum, int x, bool init);

void check(mas* sum, bool init, mas* sum2)
{
    bool f;
    if (!init)
    {
      int start=0,j=0, kol=0;
      for (int i=0; i<sum->l; i++)
      {
	while (j<=start+sum->d[i]-1)
	  kol+=sum2->d[j], j++;
	start=j;
	if (!(kol>=t && kol<=2*t))
	  return;
      }
	
    }
    if (sum->l==1 && !init)
     ans++;
    else
      PISH(sum->l,false,sum);
}
  
  void makesum(mas* sum, int x, bool init, mas* sum2)
  {
    if (x==0)
      check(sum, init, sum2);
    for (int i=1; i<10 && i<=x; i++)
      if( (init && i>=t-1 && i<= 2*t-1) || (!init && i>=t && i<= 2*t))
      {
	sum->d[sum->l++]=i;
	makesum(sum,x-i, init,sum2);
	sum->l--;
      }
  }
  

void PISH (int x, bool init, mas * sum2)
{
  mas* sum= new mas;
  sum->l=0;
  makesum(sum,x, init,sum2);
}

int main()
{
  ifstream fin("btrees.in");
  ofstream fout("btrees.out");
  fin >> n >> t;
  mas* s=new mas;
  PISH(n,true,s);
  fout << ans;
  fin.close();
  fout.close();
}