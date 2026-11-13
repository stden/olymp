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
bool used[nmax];


int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);

  scanf("%s",&s);
  int n=strlen(s);
  bool good=true;
  forn(i,n/2)
    if(s[i]!=s[n-i-1])good=false;
  
  forn(i,n)used[i]=0;
    
  if(good){
    printf("1\n%s\n",s);
    return 0;
    }
  int l=0,r=n-1;
  while(l<=r){
    cerr<<s[l]<<" "<<s[r]<<endl;
    if(s[l]==s[r]){
      used[l]=used[r]=1;
      l++;
      r--;
      }else{
      if(s[l]=='0')l++;else r--;
      }
    }
  printf("2\n");
  forn(i,n)
    if(!used[i])printf("%c",s[i]);
  printf("\n");
  forn(i,n)
    if(used[i])printf("%c",s[i]);
  printf("\n");
  return 0;
};
