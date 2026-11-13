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
typedef vector<int> tlong;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back
#define task "aplusminusb"

tlong a,b,c;

void norm(tlong &a){
  while(a.size()>1 && a.back()==0)
    a.resize(a.size()-1);
  }

void read(tlong &a){
  a.clear();
  string s;
  cin>>s;
  ford(i,s.length())
    a.pb(s[i]-'0');
  }
  
void write(tlong a){
  if(a.size()==0)printf("0");
  ford(i,a.size())
    printf("%d",a[i]);
  printf("\n");
  }
 
 tlong sub(tlong a,tlong b){
  tlong c=a;
  int l=0;
  forn(i,b.size())
    c[i]-=b[i];
 forn(i,c.size())
  while(c[i]<0){
    c[i]+=10;
    c[i+1]--;
    }
 norm(c);
 return c;
 }
 
bool more(tlong a,tlong b){
  if(a.size()!=b.size())
    return a.size()>b.size();
  int i=a.size()-1;
  while(i>0 && a[i]==b[i])i--;
  return a[i]>=b[i];
  }
  
void read(){
  read(a);
  read(b);
  }
  
void solve(){
  if(more(a,b))c=sub(a,b);else{
    cout<<'-';
    c=sub(b,a);
    }
}
  
void write(){
  write(c);
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  read();
  solve();
  write();
 
  return 0;
};
