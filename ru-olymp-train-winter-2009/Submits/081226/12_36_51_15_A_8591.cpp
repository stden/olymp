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

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back
#define mp make_pair
#define task "digitsum"

string p[2]={"11212","1121212"};

const int nmax=6*(1e6);

string s="1",now;
int64 t[nmax+1];

void gen(){
  while(s.length()<nmax){
    now="";
    forn(i,s.size())
      now+=p[s[i]-'1'];
    s=now;
    } 
  t[0]=0;
  forn(i,nmax)
    t[i+1]=t[i]+s[i]-'0';
  }
  
  

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  
  gen();
  
  int n,l,r;
  cin>>n;
  forn(i,n){
    scanf("%d%d",&l,&r);
    printf("%lld\n",t[r]-t[l-1]);
    }  
  return 0;
};
