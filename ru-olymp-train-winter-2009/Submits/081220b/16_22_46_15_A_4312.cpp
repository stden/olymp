#include<iostream>
#include<vector>
#include<string>
#include<algorithm>

using namespace std;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back

typedef vector<int> tlong;
const int osn=1000*1000*1000;

int calc(string s){
  int res=0;
  forn(i,s.size())
    res=res*10+s[i]-'0';
  return res;
}

void read(tlong &a){
  a.clear();
  string s;
  cin>>s;
  reverse(all(s));
  for(int i=(int)s.length()-1;i>=0;i-=9)
    if(i>=8)a.pb(calc(s.substr(i-8,9)));else
    a.pb(calc(s.substr(0,i+1)));
}

tlong sub(tlong a,tlong b){
  tlong res(a.size(),0);
  forn(i,a.size()){
      res[i]+=a[i]-b[i];
      if(res[i]<0){
        res[i]+=osn;
        res[i+1]--;
        }
      }
  while(res.size()>0 && res.back()==0)res.resize(res.size()-1);
  return res;
}

void print(tlong a){
  printf("%d",a.size()?a.back():0);
  ford(i,a.size()-1)
    printf("%d",a[i]);
  printf("\n");
}

bool more(tlong a,tlong b){
  if(a.size()!=b.size())	
    return a.size()>b.size();
  int i=0;
  while(i<(int)a.size()-1 && a[i]==b[i])i++;
  return a[i]>=b[i];
  }

int main(){
  freopen("aplusminusb.in","rt",stdin);
  freopen("aplusminusb.out","wt",stdout);
  tlong a,b,c;
  bool minus=false;
  read(a);
  read(b);
  if(more(a,b))c=sub(a,b);else c=sub(b,a),minus=true;
  if(minus)cout<<'-';
  print(c);
  return 0;
};
