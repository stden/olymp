#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "algorithm"

using namespace std;

struct con{
	string str;
	long long start, end;
	int speed, read, write;
};

int main()
{
	ifstream fin("calls.in");
	freopen("calls.out", "wt", stdout);
	char str[1000];
	vector<con> v;
	int n = 0;
	bool connected = 0;
	bool hanged= 0;
	
	while(!fin.eof())
	{
		fin.getline(str, 1000);
		bool r = 1;
		for(int i =0; i <=24; i++)
		{
			if(i == 2|| i==5|| i == 23)
				if(str[i] != '-'){r=0;break;}
			if(i==0|| i==1||i==3||i==4||i==6||i==7||i==8||i==9||i==1||i==12||i==14||i==15||i==17||i==18||i==20||i==21)
				if(str[i] < '0' || str[i] > '9'){r=0;break;}
			if(i == 10 || i == 22||i==24)
				if(str[i] != ' '){r=0;break;}
			if(i == 19 && str[i] != '.'){r=0;break;}
			if(i == 13 || i == 16)
				if(str[i] != ':'){r=0;break;}
		}
		if(r)
		{
			string s(str);
			if(s.find("Connection established at") != -1)
			{
				int mm,d,y,h,m,s,ms;
				sscanf(str, "%d-%d-%d %d:%d:%d.%d",&mm,&d,&y,&h,&m,&s,&ms);
				v.push_back(con());
				n++;
				v[n-1].start = s + m*60+h*60*60;
				
				sscanf(str+50, "%d",&(v[n-1].speed));
				connected = 1;
				hanged = 0;
				str[19] = 0;
				v[n-1].str = string(str);
			}
			if(s.find("Hanging up the modem.") != -1 && connected)
			{
				hanged = 1;
				int mm,d,y,h,m,s,ms;
				sscanf(str, "%d-%d-%d %d:%d:%d.%d",&mm,&d,&y,&h,&m,&s,&ms);
				v[n-1].end = s + m*60+h*60*60;
			}
			if(s.find("Reads :") != -1 && hanged)
			{
				char * ss = str+ 24;
				while(ss[0] == ' ')ss++;
				sscanf(ss+7, "%d", &(v[n-1].read));
			}
			if(s.find("Writes :") != -1 && hanged)
			{
				char * ss = str+ 24;
				while(ss[0] == ' ')ss++;
				sscanf(ss+8, "%d", &(v[n-1].write));
			}
			if(s.find("Standard Modem closed.") != -1 && hanged)
			{
				hanged = 0;
				connected = 0;
			}
		}
	}
	long long ts=0, tstp=0,r=0,w=0;
	for(int i = 0; i < v.size(); i++)
	{
		int tm = 0;
		if(v[i].start < v[i].end)
			tm = v[i].end - v[i].start;
		else
			tm = v[i].end +24*60*60 -v[i].start;
		cout << v[i].str << "    " << tm << " " << v[i].speed << " " <<v[i].read << "/" << v[i].write << endl;
		ts += tm;
		if(tm >= 60)
			tstp += tm;
		r+= v[i].read;
		w+= v[i].write;
	}
	cout << "Total seconds to pay = " << tstp << ", total seconds = " << ts << "; total bytes " << r <<"/" << w<<endl;
	return 0;
}