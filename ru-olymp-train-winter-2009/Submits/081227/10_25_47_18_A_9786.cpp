#include <iostream>
#include <cstring>
#include <cmath>
#include <cstdlib>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>
using namespace std;

#define all(c) (c).begin(),(c).end()
#define fill(c,x) memset( c, x, sizeof c )
#define pb push_back
#define for_it(c,it) for( typeof( (c).begin() ) it = (c).begin(); it!=(c).end(); it++ )
#define for_all(c,i) for(int i  = 0; i < (int)c.size(); i++)

int it;
string s;

bool tab(char c)
{
	if( c == ' ' ) return true;
	if( c == 9 ) return true;
 	if( c == '(' || c == ')' || c == ']' || c == '[' ) return true;
	return false;
}

bool isZn(char c)
{
	if( c == '.' || c == ',' || c == ':' || c == '=' || c == ';' || c == '-' ||
		c == '+' || c == '*' || c == '/' ) return true;
	return false;
}

bool isCh(char c)
{
	if( isalpha(c) || c == '_' ) return true;
	return false;
}

string getStr()
{
	while( it<(int)s.length() && tab(s[it]) ) it++;
	string res;
	if( it<(int)s.length() )
	{
		
		if( isZn(s[it]) )
		{
			while( it<(int)s.length() && isZn(s[it]) ) res += s[it++];
		} else
		if( isCh(s[it]) )
		{
			while( it<(int)s.length() && isCh(s[it]) )
			{
				res += s[it++];
				if( isalpha(s[it]) ) s[it] = tolower(s[it]);
			}
		} else
		{
			while( it<(int)s.length() && !tab(s[it]) ) res += s[it++];
		}
			
	}
	return res;
}
string getStr(char c)
{
	string res;
	while( it<(int)s.length() && s[it]!=c ) res += s[it++];
	return res;
}

int main()
{
	bool input  = false;
	bool output = false;
	bool reset = false;
	bool rewrite = false;
	bool type_int = false;
	bool const_nmax = false;
	bool w_random = false;
	int sp = 0,n_sp = 0;
	int sp2 = 0, n_sp2 = 0;
	
	
	
	freopen( "help.in", "r", stdin );
	freopen( "help.out", "w", stdout );
	string last;
	
	while( getline( cin, s ) )
	{
		it = 0;
		string tmp = getStr();
		
	while( tmp != "" )
	{
		//zn
		if( isZn(tmp[0]) )
		{
			/*
			if( tmp == ":" )
			{
				if( tab( s[it] ) ) sp2++; else n_sp2++;
			} else 
			if( tmp == "," )
			{
				if( tab( s[it] ) ) sp2++; else n_sp2++;
			} else
			*/
			if( tmp == ":=" )
			{
				if( tab( s[it - (int)tmp.length()-1] ) ) sp++; else n_sp++;
			}
		}
		//in\out
		if( tmp == "assign" ) 
		{
			last = "assign";
		}
		if( tmp == "reset" )
		{
			last = tmp;
			reset = true;
		}
		if( tmp == "rewrite" )
		{
			last = tmp;
			rewrite = true;
		}
		if( last == "assign" )
		{
			if( tmp.find(".in")!=string::npos ) input = true;
			if( tmp.find(".out")!=string::npos ) output = true;
			if( last == "reset" &&  tmp.find(".in")!=string::npos ) input = true;
			if( last == "rewrite" && tmp.find(".out")!=string::npos ) output = true;
		}
		//write
		if( tmp.find("write")!=string::npos )
		{
			last = "write";
		}
		if( last == "write" && tmp.find("rand")!=string::npos )
		{
			w_random = true;
		}
		//type
		if( tmp == "type" )
		{
			last = "type";
		}
		if( last == "type" && tmp == "int" )
		{
			type_int = true;
		}
		//const
		if( tmp == "const" )
		{
			last = "const";
		}
		if( last == "const" )
		{
			if( tmp == "nmax" ) const_nmax = true;
		}
		
		if( tmp == "var" )
		{
			last = "var";
		}
		
		if( tmp == "begin" )
		{
			last = "begin";
		}
		if( tmp == ";" )
		{
			if( last == "write" || last == "assign" || last == "reset" || last == "rewrite" )
			{
				last = "";
			}
		}
		
		tmp = getStr();
	}
	}


	if( w_random )
	{
		printf("YES");
		return 0;
	}

	if( type_int )
	{
		printf("YES");
		return 0;
	}

	/*
	if( sp >= n_sp )
	{
		printf("YES");
		return 0;
	}
	*/
	printf("NO");
	return 0;
}

