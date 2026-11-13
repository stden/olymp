#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;
#define forn(i,n) for(int i=0;i<int(n);i++)
#define ford(i,n) for(int i=int(n)-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define sqr(a) ((a)*(a))
#define id(a) isdigit(s[a])
#define elif else if

int strtoint(string s){
	int i=0,res=0;
	while(i<s.length() && id(i))
		i++;
	forn(j,i)
		res=((res*10)+((int)s[j]-48));
	return res;
}

string s;
int sec[4],speed,download,upload,total[2];

int valid(string s){
	int buf=0;
	if(s.length()<33 || s[2]!='-' || s[5]!='-' || s[10]!=' ' || s[13]!=':' || s[16]!=':' || s[19]!='.' || s.substr(22,2)!=" -")
		return 0;
	if(!id(0) || !id(1))
		return 0;
	if(!id(3) || !id(4))
		return 0;
	if(!id(6) || !id(7) || !id(8) || !id(9))
		return 0;
	if(!id(11) || !id(12))
		return 0;
	buf=strtoint(s.substr(11,2));
	if(!id(14) || !id(15))
		return 0;
	buf=buf*60+strtoint(s.substr(14,2));
	if(!id(17) || !id(18))
		return 0;
	buf=buf*60+strtoint(s.substr(17,2));
	if(!id(20) || !id(21))
		return 0;
	if(s.substr(s.length()-21,21)=="Hanging up the modem."){
		sec[2]=buf;
		return 2;
	}
	if(s.substr(s.length()-22,22)=="Standart Modem closed."){
// 		cerr<<"closed\n";
		return 5;
	}
	forn(i,s.length()+1-8)
		if(s.substr(i,8)=="Reads : "){
// 			cerr<<"download\n";
			download=strtoint(s.substr(i+8,s.length()-i-8));
			return 3;
		}
		elif(s.substr(i,8)=="Writes: "){
// 			cerr<<"upload\n";
			upload=strtoint(s.substr(i+8,s.length()-i-8));
			return 4;
		}
	forn(i,s.length()-26)
		if(s.substr(i,26)=="Connection established at "){
// 			cerr<<"established\n";
			sec[1]=buf;
			speed=strtoint(s.substr(i+26,s.length()-i-26));
			return 1;
		}
	return 0;
}

int main(){
	freopen("calls.in","rt",stdin);
	freopen("calls.out","wt",stdout);
	int established=sec[0]=sec[1]=sec[2]=sec[3]=total[0]=total[1]=0,type;
	while(getline(cin,s)){
		type=valid(s);
		if(type==established+1 || ( type == 3 && established == 3 ) || ( type == 4 && established == 2)){
			established++;
			established%=5;
			if(type==1){//established
				cout<<s.substr(0,19)<<"    ";
			}elif(type==2){//handing up
				printf("%d %d " ,((sec[2]-sec[1]+24*60*60)%(24*60*60)),speed);
				sec[0]+=(sec[2]-sec[1]+24*60*60)%(24*60*60);
				sec[3]+=((sec[2]-sec[1]+24*60*60)%(24*60*60)<60)?0:((sec[2]-sec[1]+24*60*60)%(24*60*60));
			}elif(type==3){//download
				printf("%d/",download);
			}elif(type==4){//upload
				printf("%d\n",upload);
			}elif(type==5){//modem closed
				total[0]+=download;
				total[1]+=upload;
			}
		}
	}
	printf("Total seconds to pay = %d, total seconds = %d; total bytes %d/%d",sec[3],sec[0],total[0],total[1]);
	return 0;
}
