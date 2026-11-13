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
#define task "palin"

const int nmax=3000100;
const int inf=nmax*2;

char s[nmax];
int t[nmax],p[nmax];
int np[nmax],cp[nmax];

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);

  scanf("%s",&s);
  
  int n=strlen(s);
  
  int l=0,r=0;
  forn(i,n){
    np[i]=0;
    if(i<r)np[i]=np[2*l-i];
    while(np[i]<=i && s[i-np[i]]==s[i+np[i]])np[i]++;
    np[i]--;
    if(i+np[i]>r){
      l=i;
      r=i+np[i];
      }
    }
    
  l=0,r=0;
  forn(i,n){
    cp[i]=0;
    if(i<r)cp[i]=np[2*l-i-1];
    while(cp[i]<i && s[i-cp[i]-1]==s[i+cp[i]])cp[i]++;
    if(i+cp[i]>r){
      l=i;
      r=i+cp[i];
      }
    }
    
/*  forn(i,n){
    np[i]=0;
    while(np[i]<=i && s[i-np[i]]==s[i+np[i]])np[i]++;
    np[i]--;
    }
  forn(i,n){
    cp[i]=0;
    while(cp[i]<i && s[i-cp[i]-1]==s[i+cp[i]])cp[i]++;
    }

  forn(i,n){
    cerr<<np[i]<<" "<<cp[i]<<endl;
    }
*/  
  forn(i,n+1)t[i]=inf,p[i]=-1;
  t[0]=0;
  forn(i,n){
    forn(j,np[i]+1)
      if(t[i+j+1]>=t[i-j]+1){
        t[i+j+1]=t[i-j]+1;
        p[i+j+1]=i-j;
        }
    forn(j,cp[i]){
      if(t[i+j+1]>=t[i-j-1]+1){
        t[i+j+1]=t[i-j-1]+1;
        p[i+j+1]=i-j-1;
        }
      }
    }
  int now=n;
  printf("%d\n",t[now]);
  while(now!=0){
    int l=p[now],r=now;
    for(int i=r-1;i>=l;i--)
      printf("%c",s[i]);
    printf("\n");
    now=p[now];
    }
  return 0;
};
