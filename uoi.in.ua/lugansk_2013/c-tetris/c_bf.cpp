#include <iostream>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <algorithm>
#include <map>
#include <vector>
#include <cstdio>
#include <cmath>

using namespace std;

int n,i,x,j,ost,num,need,all,ans,size,ok,jj,jjj,ma,ii;
int a[100000],b[1000],c[1000];
int q[1 << 17];
int qq[1 << 17];
int let = 4;
string s;

int get(char v)
{
    if (v == 'A') return 0;
    if (v == 'G') return 1;
    if (v == 'T') return 2;
    if (v == 'V') return 3;            
}

int main()
{
    freopen("a.dat","r",stdin);
    freopen("a.sol","w",stdout);    
    
    cin >> n;
    for (i=0;i<n;i++)        
        cin >> a[i];
    
    for (i=0;i<n;i++){cin >> x;
        a[i] = (x - a[i] + let)%let;}

    for (i = 1;i<(1 << (2*n)); i++)
        q[i] = 1000000000;
        
    size = 1;
    i = 1;
    while (i<=size)    
    {
          ok = 1;
          for (j = 0;j<n;j++)
              {
                   b[j] = 0;
                   if ((qq[i] & (1 << (j*2)))) b[j] += 2;
                   if ((qq[i] & (1 << (j*2+1)))) b[j] += 1;                   
                   
                   if (b[j] != a[j]) ok = 0;
              }
              
          if (ok)
          {
                 cout << q[qq[i]] << endl;
                 return 0;
          }
              
          for (jj = 0; jj <n; jj++)
          {
              for (jjj = 0; jjj < n; jjj++)
                  c[jjj] = b[jjj];
              for (jjj = jj; jjj< n; jjj++)
                  {
                       c[jjj] = (c[jjj]+1)%4;
                       ma = 0;
                       for (ii = 0; ii<n;ii++)
                       {
                           if (c[ii] & 2) ma += (1 << (2*ii));
                           if (c[ii] & 1) ma += (1 << (2*ii+1));
                       }
                       if (q[ma] == 1000000000)
                       {
                                 q[ma] = q[qq[i]]+1;
                                 size++;
                                 qq[size] = ma;
                       }
                  }
          }
          i++;
    }
     
//    system("pause");
    return 0;
}
