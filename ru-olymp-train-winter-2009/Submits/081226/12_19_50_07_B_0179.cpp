#include <fstream>

const int inf=1000000;

using namespace std;

int main()
{
    ofstream fout("half.out");
  ifstream fin("half.in");
  
  int n,m,a[900],b[900];
  
  fin >> n >> m;
  for (int i=0; i<m; i++)
    fin >> a[i] >> b[i];
  int w = (1<<(n/2))-1;
  int q = (1<<n)-1-w;
  int min=inf;
  int mins=-1;
  
  for (int s=w; s<=q; s++)
  {
    int k=0;
    int s1=0, s2=0;
    for (int i=1; i<=n && s%2==0; i++)
    {if (((s>>(i-1))%2)==0)
	s1++;
      else
	s2++;}
     
      if (s1==s2 && s%2==0)
      {
	for (int j=0; j<m; j++)
	{
	  if (((s>>(a[j]-1))%2)!=((s>>(b[j]-1))%2))
	    k++, s1++, s2++;
	}
	if (k<min && s1==s2 && s%2==0)
	  min=k, mins=s;
      }
  }
  
 // int f =(mins>>(n-1))%2;
  fout << 1 << ' ';
  for (int i=2; i<=n; i++)
    if (((mins>>(i-1))%2)==0)
      fout << i << ' ';
   fin.close();
  fout.close();
}