// score: 35
// cross-solution by Serhiy Nahin
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

int n,i,j,m,k,mm,nn;
long long x[100000], y[100000], r[100000], q[100000], rr, xx[100000], yy[100000], zz[100000], tot[100000], c[100000];
int num[100000];
int a[100000], b[100000], pr[100000], next[100000];
long long sum[100000], aa[100000];
long long opt, tmp;

void add(int x, int y, long long z)
{
     mm++;
     a[mm] = x;
     b[mm] = y;
     c[mm] = z;
     next[mm] = pr[x];
     pr[x] = mm;
 }
 
void go(int v, int pre)
{
     int i = pr[v];
     sum[v] = tot[v];
     while (i)
     {
           if (b[i] != pre) 
           {
                    go(b[i], v);
                    sum[v] = sum[v] + sum[b[i]];
                    aa[i] = (sum[b[i]] * c[i]);
           } else aa[i] = 0;
           i = next[i];
     }
}

int main()
{
    freopen("camelot.dat","r",stdin);
    freopen("camelot.sol","w",stdout);    
    cin >> n >> m >> k;
    for (i=1;i<=n;i++)
    {
        cin >> x[i] >> y[i] >> r[i] >> q[i]; 
    }
    
    for (i=1;i<=n;i++)
    {
        rr = 1000000000;
        num[i] = 0;
        for (j=1;j<=n;j++)
        if (r[j]>r[i])
           if (r[j]<rr)
           {            
                        if ((x[i]-x[j])*(x[i]-x[j]) + (y[i]-y[j])*(y[i]-y[j]) <= r[j]*r[j])            
                        {
                                        rr = r[j];
                                        num[i] = j;
                        }
           }
        add(num[i], i, q[i]);
        add(i, num[i], q[i]);
    }
    
    for (i=1;i<=m;i++)
    {
        cin >> xx[i] >> yy[i] >> zz[i];
        nn = 0;
        rr = 1000000000;
        for (j = 1; j <= n; j++)
            if (rr > r[j])
               {
                   if ((xx[i]-x[j])*(xx[i]-x[j]) + (yy[i]-y[j])*(yy[i]-y[j]) <= r[j]*r[j])            
                        {
                                        rr = r[j];
                                        nn = j;
                        }
               }
        tot[nn] += zz[i];
    }
    
//    for (i=0;i<=n;i++) cout << tot[i] << endl;
    
    opt = 1000000000000000000LL;
    
    for (i=0;i<=n;i++)
    {
        tmp = 0;
        
        go(i, -1);
                            
        sort(aa+1,aa+mm+1);
        reverse(aa+1,aa+mm+1);
        for (j=k+1;j<=mm;j++)
            tmp += aa[j];
        
        opt = min(opt, tmp);        
    }
    
    cout << opt << endl;
        
    return 0;
}
