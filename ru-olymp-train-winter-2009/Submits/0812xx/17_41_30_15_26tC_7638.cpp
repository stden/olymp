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
#define task "next"

void calc_z (string s, vector<int> & z)
{
	int len = (int) s.length();
	z.resize (len);

	int l = 0, r = 0;
	for (int i=1; i<len; ++i)
		if (z[i-l]+i <= r)
			z[i] = z[i-l];
		else
		{
			l = i;
			if (i > r) r = i;
			for (z[i] = r-i; r<len; ++r, ++z[i])
				if (s[r] != s[z[i]])
					break;
			--r;
		}
}

void make(string &s,int x){
  s[x]='0';
  for(int i=x+1;i<s.size();i++)s[i]='1';
  vector<int> z;
  calc_z(s,z);
  bool good=true;
  for(int i=1;i<s.size();i++)
    if(i+z[i]>=s.size() || (i+z[i]<s.size() && s[i+z[i]]<s[z[i]]))good=false;
  if(good)return;
  s[x]='1';  
  }
    
string s,res;    
    
void solve(){
  res=s;
  int n=s.length();
  int r=n-1;
  while(res[r]=='1')r--;
  res[r]='1';
  for(int i=r+1;i<res.size();i++)make(res,i);
 }
   
int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  cin>>s;
  solve();
  printf("%s\n",res.data());    
  return 0;
};
