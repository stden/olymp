#include<iostream>
#include<vector>
#include<string>
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

void more(int64 &t1,int64 t2,int64 &r1,int64 r){
  if(t1<t2)t1=t2,r1=r;
}    

int64 calc(string s){
  int64 res=0;
  forn(i,s.size())
    res=res*10+s[i]-'0';
  return res;
  }

int main(){
  freopen("stress.in","rt",stdin);
  freopen("stress.out","wt",stdout);
  
  string s;
  int64 rs,t1=0,t2=0,r1=0,r2=0,r;
  int64 kol=0;
  while(cin>>s){
    if(s=="randseed"){
      cin>>s>>rs;
      printf("At randseed = %lld\n",rs);
      kol=0;
      };
    if(s=="Work"){
      cin>>s;
      if(s=="time:"){
	      string q;
	      cin>>s>>q;
	      if(q=="ms"){
	      int64 i=0;
	      while(i<s.length() && s[i]!=',')i++;
	      s=s.substr(0,i);
	      if(kol==0)
	        printf("First: %s ms\n",s.data()),more(t1,calc(s),r1,rs);
	        else
	        printf("Second: %s ms\n",s.data()),more(t2,calc(s),r2,rs);
	      kol++;
	      };
	      };
      };
   };
   printf("Maximal work time for first: %lld at randseed = %lld\n",t1,r1);
   printf("Maximal work time for second: %lld at randseed = %lld\n",t2,r2);
  return 0;
};
