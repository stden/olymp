#include <fstream>

using namespace std;

int main()
{
  ifstream fin("cube.in");
  ofstream fout("cube.out");
  
  long long n,m, q;
  fin >> q;
  
  long long a[10000], f[10000];
  
   n = 1<<q;
  for (long long i=0; i<n; i++)
    fin >> a[i];
  
  m = 1<<n;
  for (long long s=0; s<n; s++)
  {
    int max=0;
    for (long long i=0; i<n; i++)
    { 
      if (s&(1<<i))
	if (max<f[s-(1<<i)])
	    max=f[s-(1<<i)];
     
    }
     f[s]=max+a[s];
   
  }
  
  long long max=-1;
  
  for (long long i=0; i<n; i++)
    if (f[i]>max) max=f[i];
    
   fout << max;
  fin.close();
  fout.close();
}