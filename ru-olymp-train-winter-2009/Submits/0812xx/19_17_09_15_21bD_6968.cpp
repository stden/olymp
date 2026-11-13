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
typedef long long int64;
#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back

int dl[13]={31,28,31,30,31,30,31,31,30,31,30,31,31};

int64 calc3(int x){
  int64 res=0;
  forn(i,x-1)res+=dl[i];
  return res;
  }

int64 calc(string s){
  int64 res=atoi(s.substr(6,4).c_str());
  res=res*365+atoi(s.substr(3,2).c_str());
  res=res+calc3(atoi(s.substr(0,2).c_str()));
  res=(int64)(res*24*3600);
  return res;
  }

int64 calc2(string s){
  int64 res=0;
  res=atoi(s.substr(0,2).c_str());
  res=res*60+atoi(s.substr(3,2).c_str());
  res=res*60+atoi(s.substr(6,2).c_str());
  return res;
  }

bool good(string s){
  if(!isdigit(s[0]))return false;
  if(!isdigit(s[1]))return false;
  if(!isdigit(s[3]))return false;
  if(!isdigit(s[4]))return false;
  if(!isdigit(s[6]))return false;
  if(!isdigit(s[7]))return false;
  if(!isdigit(s[8]))return false;
  if(!isdigit(s[9]))return false;
  if(s[2]!='-')return false;
  if(s[5]!='-')return false;
  return true;
  }

bool good2(string s){
  if(!isdigit(s[0]))return false;
  if(!isdigit(s[1]))return false;
  if(s[2]!=':')return false;
  if(!isdigit(s[3]))return false;
  if(!isdigit(s[4]))return false;
  if(s[5]!=':')return false;
  if(!isdigit(s[6]))return false;
  if(!isdigit(s[7]))return false;
  return true;
  }

void solve(){
  string s,s1,t;
  int64 start,v;
  int64 pay,all,take,give;
  take=give=pay=all=0;
  bool conect=false;
  while(cin>>s){
    if(good(s)){      
    int64 now=calc(s);  
    t=s;
    cin>>s;
    if(good2(s)){
    now+=calc2(s.substr(0,8));
    t=t+" "+s.substr(0,8);
    cin>>s>>s;
    if(s=="Connection"){
      cin>>s;
      if(s=="established"){
        cin>>s;
        if(s=="at"){
        cin>>s;
        string s1=s.substr(s.size()-4,4);
        if(s1=="bps."){
	s.resize(s.size()-4);
	start=now;
	v=atoi(s.c_str());
	cout<<t<<"    ";
	conect=true;
	}
	}
	}
	}else
     if(s=="Hanging"){
      cin>>s;
      if(s=="up"){
        cin>>s;
        if(s=="the"){
        cin>>s;
        if(s=="modem.")
	if(conect){
        int64 res=now-start;
        if(res>720)res-=24*3600;
        all+=res;
        if(res>=60)pay+=res;
        printf("%lld %lld ",res,v);
        conect=true;
        }
        }
        }
        }else
     if(s=="Reads"){
      cin>>s;
      if(s==":"){
        cin>>s;
        string s1;
        cin>>s1;
        if(s1=="bytes")cout<<s<<"/",take+=atoi(s.c_str());
        }
      }else
     if(s=="Writes:"){
        cin>>s;
        string s1;
        cin>>s1;
        if(s1=="bytes")cout<<s<<endl,give+=atoi(s.c_str());
      }
    }
    }
      getline(cin,s);
     
     }
     printf("Total seconds to pay = %lld, total seconds = %lld; tolal bytes %lld/%lld\n",pay,all,take,give);
}
 
 int main(){
  freopen("calls.in","rt",stdin);
  freopen("calls.out","wt",stdout);
  
  solve();
  
  return 0;
  
  
};
