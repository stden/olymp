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

typedef pair<int,int> pi;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back

string m[12]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
int dl[12]={31,28,31,30,31,30,31,31,30,31,30,31};
pair<int,int> serv;
string nado;

pair<int,int> time(string s){
  pair<int,int> res;
  bool minus=false;
  if(s[0]=='-')minus=true;
  s=s.substr(1,4);
  res.fs=((s[0]-'0')*10+s[1]-'0');
  res.sc=((s[2]-'0')*10+s[3]-'0');
  if(minus){
    res.fs*=-1;
    res.sc*=-1;
    };
  return res;
  };
  
void read(){
  string s;
  getline(cin,s);
  nado=s;
  serv=time(nado);
  };

int nom(string s){
  forn(i,12)
    if(m[i]==s)return i;
  };

vector<int> make(string s){
  vector<int> res(6,0);
  res[0]=((s[0]-'0')*10+s[1]-'0');
  res[1]=nom(s.substr(3,3));
  res[2]=atoi(s.substr(7,4).c_str());
  res[3]=((s[12]-'0')*10+s[13]-'0');
  res[4]=((s[15]-'0')*10+s[16]-'0');
  res[5]=((s[18]-'0')*10+s[19]-'0');
  return res;
  }
  
int d(int x,int y){
  int res=dl[x];
  if(x==1 && y%4==0)res++;
  return res;
  }

char buf[1000000]; 
char s1[1000000],sa[100],ta[100];
string s,t;
          
void solve(){
  string s;
  char ch;
  while(1){
    if(!gets(buf))break;
    if(!buf[0])continue;
    sscanf(buf,"%s %s %s [%s %s",s1,s1,s1,sa,ta);
    s=sa;
    t=ta;
    t.resize(5);
    pair<int,int> ad=time(t);
      ad.fs-=serv.fs;
      ad.sc-=serv.sc;
      vector<int> now=make(s);
      now[4]-=ad.sc;
      now[3]-=ad.fs;
      while(now[4]<0){
        now[4]+=60;
        now[3]--;
        }
      while(now[4]>=60){
        now[4]-=60;
        now[3]++;
        }
      while(now[3]<0){
        now[3]+=24;
        now[0]--;
        }
      while(now[3]>=24){
        now[3]-=24;
        now[0]++;
        }
      while(now[0]<=0){
        now[1]--;
        while(now[1]<0){
	  now[1]+=12;
	  now[2]--;
	  }
        now[0]+=d(now[1],now[2]);
        }
      cerr<<now[0]<<endl;  
      while(now[0]>d(now[1],now[2])){
        now[0]-=d(now[1],now[2]);
        now[1]++;
        while(now[1]>=12){
	  now[1]-=12;
	  now[2]++;
	}
        }      
      while(now[1]<0){
        now[1]+=12;
        now[2]--;
        }
      while(now[1]>=12){
        now[1]-=12;
        now[2]++;
        }
      int i=0;
      while(buf[i]!='['){
        printf("%c",buf[i]);
        i++;
        }
      printf("[%02d/%s/%04d:%02d:%02d:%02d %s",now[0],m[now[1]].data(),now[2],now[3],now[4],now[5],nado.data());
      while(buf[i]!=']')i++;
      int n=strlen(buf);
      while(i<n){
        printf("%c",buf[i]);
        i++;
        }
      printf("\n");
      }
 cout<<endl;
};
 
 int main(){
  freopen("apache.in","rt",stdin);
  freopen("apache.out","wt",stdout);
  
  read();
  solve();
  
  return 0;
  
  
};
