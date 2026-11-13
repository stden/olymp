#include <fstream>

using namespace std;

int main()
{
  ifstream fin("modsum2.in");
  ofstream fout("modsum2.out");
  
  long long n, a[20], f[65556];
  
  fin >> n;
  long long sum=0;
  for (long long i=0; i<n; i++)
    fin >> a[i];
  
  long long m = 1<<n;
  
  for (long long s=1; s<m;s++)
  {
    long long s1=s;
    f[s]=0;
    for (int i=0; i<n; i++)
      f[s]+=a[i]*(s1%2), s1/=2;
  }
    
  for (long long  s=1; s<m; s++)
  {
    long long s1=(m-1)&(~s);
    for (long long t=s1; t>0; t=(t-1)&s1)
     {
	sum+=f[s]%f[t];
     }
  }
   fout << sum;
}