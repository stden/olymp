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
#define task "room"

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
  
tlong sum(tlong a,tlong b){
  int n=max(a.size(),b.size());
  tlong c(n,0);
  int l=0;
  forn(i,n){
    int now=l;
    if(i<a.size())now+=a[i];
    if(i<b.size())now+=b[i];    
    c[i]=now%10;
    l=now/10;
    }
 if(l>0)c.pb(l);
 norm(c);
 return c;
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
 
tlong mul(tlong a,tlong b){
  int n=a.size()+b.size();
  tlong c(n,0);
  forn(i,a.size())	
    forn(j,b.size())
      c[i+j]+=a[i]*b[j];
  forn(i,c.size()){
    int l=c[i];
    c[i]=l%10;
    l/=10;
    if(i==c.size()-1 && l>0)c.pb(0);
    c[i+1]+=l;
    }
  norm(c);
  return c;
  }
  
tlong mul(tlong a,int b){
  forn(i,a.size())
    a[i]*=b;
  forn(i,a.size()){
    int ad=a[i]/10;
    a[i]%=10;
    if(i==a.size()-1 && ad>0)a.pb(0);
    a[i+1]+=ad;
    }
  norm(a);
  return a;
  }
    
  
  
tlong mins(tlong a){
  norm(a);
  if(a.size()==1 && a[0]==0)return a;
  a[0]--;
  int i=0;
  while(a[i]<0){
    a[i]+=10;
    a[i+1]--;
    i++;
    }
  norm(a);  
  return a;
  }
  
tlong inc(tlong a){
  norm(a);
  a[0]++;
  int i=0;
  while(a[i]>=10){
    a[i]-=10;
    if(i==a.size()-1)a.pb(0);
    a[i+1]++;
    i++;
    }
  norm(a);
  return a;
  }
  
tlong div(tlong a,int b){
  int now=0;
  ford(i,a.size()){
      int q=(now*10+a[i])/b;
      now=(now*10+a[i])%b;
      a[i]=q;
      }
   norm(a);
   return a;
   }

tlong mod(tlong a,int b){
  int now=0;
  ford(i,a.size()){
      int q=(now*10+a[i])/b;
      now=(now*10+a[i])%b;
      a[i]=q;
      }
   tlong res;
   res.pb(now);
   forn(i,res.size()){
      int ad=a[i]/10;
      a[i]%=10;
      if(i==res.size()-1 && ad>0)res.pb(0);
      res[i+1]+=ad;
    }
    
   norm(res);
   return res;
   }
  
tlong calc(tlong a){
  tlong b=mins(a);
  tlong res=mul(a,b);
  res=div(res,2);
  return res;
  }
  
tlong sum1(tlong a0,int d,tlong n){
  tlong res;
  res=sum( mul(a0,n) , mul(calc(n),d));
  return res;
  }
  
tlong n,res,res2;
int n1=13;
  
void read(){
  read(n);
  }
  
void solve(){
  if(n.size()==1 && n[0]<=3){
    if(n[0]==1)res.pb(1);
    if(n[0]==2)res.pb(2);
    if(n[0]==3)res.pb(4);
    return;
    }
  tlong a0,k;
  a0=sum( mul(div(n,3),2), mod(n,3) );
  k=div(n,3);
  tlong r=mod(n,3);
  if(r[0]>=1)k=inc(k);
  int d=2;
  tlong aa0;
  aa0=mul(tlong(1,2),mins(k));
  a0=sub(a0,aa0);
  res=sum1(a0,d,k);

  n=mins(n);
  a0=mul(div(n,3),2);
  r=mod(n,3);
  if(r[0]==2)a0=inc(a0);
  k=div(n,3);
  if(r[0]>=1)k=inc(k);

  aa0=mul(tlong(1,2),mins(k));
  a0=sub(a0,aa0);
  res=sum(res,sum1(a0,d,k));
  
  n=mins(n);
  a0=mul(div(n,3),2);
  r=mod(n,3);
  if(r[0]>=1)a0=inc(a0);
  k=div(n,3);
  if(r[0]>=1)k=inc(k);

  aa0=mul(tlong(1,2),mins(k));
  a0=sub(a0,aa0);
  res=sum(res,sum1(a0,d,k));
  };
  
void solve2(){
  res2.clear();
  int a[200][200];
  forn(i,n1)
    a[0][i]=((i+1)%3)?1:0;
  for(int i=1;i<n1;i++)
    forn(j,n1-i)
      a[i][j]=(a[i-1][j]+a[i-1][j+1])%2;
  res2.pb(0);
  int ans=0;
  forn(i,n1)
    forn(j,n1-i)
      if(a[i][j])res2=inc(res2);
  //write(res2);
  }
  
void write(){
  write(res);
  }


bool eq(tlong a,tlong b){
  norm(a);
  norm(b);
  if(a.size()!=b.size())return false;
  forn(i,a.size())
    if(a[i]!=b[i])return false;
  return true;
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  read();
  solve();
  write();
 
  return 0;
};
