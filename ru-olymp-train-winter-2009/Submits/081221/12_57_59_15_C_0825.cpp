#include<iostream>
#include<vector>
#include<string>
#include<algorithm>
#include<set>
#include<map>
#include<queue>
#include<deque>

using namespace std;

typedef pair<int,int> pi;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back

const int nmax=101000;

int n;
int a[nmax],s[nmax];
string res[nmax];

void read(){
  scanf("%d",&n);
  forn(i,n)
    scanf("%d",&a[i]);
  s[0]=0;
  forn(i,n)
    s[i+1]=s[i]+a[i];
  forn(i,n)
    res[i]="";
  };
  
void solve(int l,int r){
  if(l>=r)return;
  int now=s[r+1]-s[l],q=0,l1=-1;
  for(int i=l;i<=r;i++){
    if(q*2>=now && l1==-1)l1=i;else
    if(q*2<now)q+=a[i];
    }
  if(l1==-1){
    l1=r;
    q-=a[r];
    }
  int w=now-q;
  if(l1>0 && abs(w-q)>abs(w-q+2*a[l1-1]))l1--;  
  for(int i=l;i<=r;i++)
    if(i<l1)res[i]+='0';else res[i]+='1';
  
  solve(l,l1-1);
  solve(l1,r);
  }
  
void write(){
  forn(i,n)
    printf("%s\n",res[i].data());
  };


int main(){
  freopen("code.in","rt",stdin);
  freopen("code.out","wt",stdout);
  
  read();
  solve(0,n-1);
  write();
  return 0;
};
