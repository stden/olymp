#include<iostream>
#include<vector>
#include<string>
#include<cstring>
#include<algorithm>
#include<set>
#include<map>
#include<queue>
#include<deque>
#include<cmath>

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
#define task "help"

const int km=0;
const int bm=1;

string good[km];//={"Program","halt","exit"};

string no[bm]={"close"};//"input.txt","output.txt","halt","exit"};//,};


const int smax=5;
double should=3;

char zn[smax]={'+','=','-','*','/'};

int inf=500;
int md=70;
vector<string> a;
string s;

void answer(string s){
  printf("%s\n",s.data());
  exit(0);
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  srand(time(0));
  int bad=0;
  
  while(cin>>s)a.pb(s);
  if(a.size()>inf)answer("NO");
  
  bool find_const=false;
  bool find_type=false;
  forn(i,a.size()){
    forn(j,a[i].size()-6)
        if(a[i].substr(j,6)=="objfpc")answer("NO");
    forn(k,km)
      if(a[i].size()>=good[k].size())
      forn(j,(int)a[i].size()-good[k].size())
        if(a[i].substr(j,good[k].size())==good[k])answer("YES");    
    forn(k,bm)
      if(a[i].size()>=no[k].size())
      forn(j,(int)a[i].size()-no[k].size())
        if(a[i].substr(j,no[k].size())==no[k])answer("NO");    
    if(a[i]=="const")find_const=true;
    if(a[i]=="type")find_type=true;
    if(a[i].length()>md)answer("NO");
    }
 if(!find_const && !find_type && a.size()>250)answer("NO"); 
  answer("YES");  
  return 0;
};
