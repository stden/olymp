#include <fstream>

using namespace std;

int main()
{
  ifstream fin("modsum2.in");
  ofstream fout("modsum2.out");
  
  long long n, a[1000000];
  
  fin >> n;
  long long sum=0;
  for (long long i=0; i<n; i++)
    fin >> a[i];
  
  long long m = 1<<n;
  for (long long  s=1; s<m; s++)
  {
    long long s1=(m-1)&(~s);
    for (long long t=s1; t>0; t=(t-1)&s1)
      if ((s&t)==0)
      {
	long long as=0,bs=0,s1=s,t1=t;
	for (int i=0; i<n; i++)
	  as+=a[i]*(s1%2), s1/=2;
	for (int i=0; i<n; i++)
	  bs+=a[i]*(t1%2), t1/=2;
	sum+=as%bs;
      }
  }
   fout << sum;
}