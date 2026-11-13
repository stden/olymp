#include<iostream>
#include<vector>
#include<string>
#include<cstring>
#include<algorithm>
#include<set>
#include<map>
#include<queue>
#include<deque>

using namespace std;

typedef long long int64;
typedef long double real;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back
#define mp make_pair
#define task "modsum"

int n;
int a[20];

int pow(int x,int n){
  if(n==0)return 1;
  return x*pow(x,n-1);
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  cin>>n;
  forn(i,n)
    cin>>a[i];
  int64 res=0;
  int kol=pow(3,n);
  forn(q,kol){
    int i=q;
    int s1=0,s2=0;
    forn(j,n){
      if(i%3==1)s1+=a[j];
      if(i%3==2)s2+=a[j];
      i/=3;
      }
    if(s2!=0)res+=s1%s2;
    }
  cout<<res<<endl;
  return 0;
};
