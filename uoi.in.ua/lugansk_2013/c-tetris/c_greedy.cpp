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

int n,i,j,ans;
int a[100000];
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
    cin >> s;
    n = s.size();
    for (i=0;i<n;i++)        
        a[i] = get(s[i]);
    cin >> s;
    
    for (i=0;i<n;i++)
        a[i] = (get(s[i]) - a[i] + let)%let;

    for (i=0;i<n;i++)
    {
        while (a[i])
        {
              for (j = n-1;j>=i;j--)
              {
                  if (a[j])
                     {
                           ans++;
                           while (j>=i)
                           {
                                 a[j] = (a[j]+3)%4;
                                 j--;
                           }
                           break;
                     }
              }
        }
        
    }
    
    cout << ans << endl;
        
//    system("pause");
    return 0;
}
