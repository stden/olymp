#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;
#define forn(i,n) for(int i=0;i<int(n);i++)
#define ford(i,n) for(int i=int(n)-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define sqr(a) ((a)*(a))

int strtoint(string a){
	int i=0,res=0;
	while(i<a.length() && a[i]>47 && a[i]<59)
		i++;
	forn(j,i)
		res=((res*10)+((int)a[j]-48));
	cerr<<i<<' '<<a<<' '<<res<<endl;
	return res;
}

int main(){
	freopen("stress.in","rt",stdin);
	freopen("stress.out","wt",stdout);
	char c=' ';
	cin>>c;
	string s="",prew="qwerty";
	int now[2],best[2],rand,_rand[2];
	best[0]=best[1]=0;
	while(1){
		while(s.length()<11 || s.substr(0,11)!="randseed = "){
			getline(cin,s);
			s=c+s;
			if(!(cin>>c)){
				printf("Maximal work time for first: %d at randseed = %d\n",best[0],_rand[0]);
				printf("Maximal work time for second: %d at randseed = %d\n",best[1],_rand[1]);
				return 0;
			}
		}
		rand=strtoint(s.substr(11,s.length()-11));
		printf("At randseed = %d\n",rand);
		while(s.substr(0,11)!="Work time: ")
			getline(cin,s);
		now[0]=strtoint(s.substr(11,s.length()-11));
		printf("First: %d ms\n",now[0]);
		s="";
		while(s.substr(0,11)!="Work time: ")
			getline(cin,s);
		now[1]=strtoint(s.substr(11,s.length()-11));
		printf("Second: %d ms\n",now[1]);
		forn(i,2)
			if(now[i]>best[i])
				best[i]=now[i],_rand[i]=rand;
	}
	return 0;
}
