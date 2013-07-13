#include <fstream>

using namespace std;

int main()
{
  ifstream fin("modsum.in");
  ofstream fout("modsum.out");
  
  long long n, a[1000000];
  
  fin >> n;
  long long sum=0;
  for (long long i=0; i<n; i++)
    fin >> a[i];
  
  long long m = 1<<n;
  for (long long  s=1; s<m; s++)
    for (long long t=1; t<m; t++)
      if ((s&t)==0)
      {
	long long as=0,bs=0,s1=s,t1=t;
	for (int i=0; i<n; i++)
	  as+=a[i]*(s1%2), s1/=2;
	for (int i=0; i<n; i++)
	  bs+=a[i]*(t1%2), t1/=2;
	sum+=as%bs;
      }
      
   fout << sum;
}