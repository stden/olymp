#include <fstream>
#include <iostream>

using namespace std;

const int maxn=1136689;
const int inf =-1;

  int t, l[50000],r[50000], maxr=-inf, maxp=0;
  long long sum[maxn+1];

string a, b;

long long sumar(int l, int r)
{
  sum[0]=0;
  int ans=0;
  
  if (r<=maxp)
    return (sum[r]-sum[l-1]);
  
  if ((r-l)>maxr/3)
  {
   // cout << "pred";
    for (int i=maxp+1; i<=r; i++)
      sum[i]+=int(b[i-1]) - int('0')+sum[i-1];
    maxp=r;
    ans=sum[r]-sum[l-1];
  }
  else
  {
    for (int i=l; i<=r; i++)
      ans+=int(b[i-1]) - int('0');
  }
  return ans;
}

int main()
{
  ifstream fin("digitsum.in");
  ofstream fout("digitsum.out");

  
  fin >> t;
  
  maxp=0;
  
  for (int i=0; i<t; i++)
  {
    fin >> l[i] >> r[i];
    if (r[i]>maxr)
      maxr=r[i];
  }
  
  if (maxn<maxr)
    maxr=maxn;
 
  a="1";
  b="1";
  while (b.length()<maxr)
  {
    a=b;
    b="";
    for (int i=0; i<a.length(); i++)
    {
      if (b.length()>=maxr)
	break;
      if (a[i]=='1')
	b+="11212";
      else
	b+="1121212";
    }
  }
  
  for (int i=0; i<t; i++)
    fout << sumar(l[i],r[i]) << '\n';
    
   fin.close();
  fout.close();
}