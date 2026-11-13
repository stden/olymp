#include <iostream>
#include <cstring>
#include <string>
#include <queue>
using namespace std;

const int kx[8] = {0,1,1,1,0,-1,-1,-1};
const int ky[8] = {1,1,0,-1,-1,-1,0,1};
const int rx[4] = {0,1,0,-1};
const int ry[4] = {1,0,-1,0};

typedef int board[10][10];

struct chessman
{
	int x,y;
	bool live;
	chessman()
	{
		live = false;
	}
	chessman(int _x,int _y)
	{
		x = _x;
		y = _y;
		live = true;
	}
};

struct chess
{
	chessman k1,q1,r1;
	chessman k2,q2,r2;
	int back;
};

struct go
{
	string s;
	int back;
	go(){}
	go(char type,int x1,int y1,int x2,int y2,int _back)
	{
		s.clear();
		s += type;
		s += x1+'a';
		s += y1+'1';
		s += '-';
		s += x2+'a';
		s += y2+'1';
		back = _back;
	}
};

vector <go> answer;
queue< chess > q;
chess tmp;
vector <string> res;
bool exit = false;

void game_over(go last)
{
	res.push_back( last.s );
	while( last.back != (-1) )
	{
		last = answer[ last.back ];
		res.push_back( last.s );
	}
	for(int i=(int)res.size()-1; i>=0; i--)
	{
		cout << res[i] << endl;
	}
	exit = true;
}

bool on_board(int x,int y)
{
	return ( 0<=x&&x<8 && 0<=y&&y<8 );
}

void past(
			chessman &k1, chessman &q1, chessman &r1,
			chessman &k2, chessman &q2, chessman &r2,
			board &b)
{
	memset( b, 0, sizeof b );
	if( k2.live )	b[k2.x][k2.y] = 2;
	if( q2.live )	b[q2.x][q2.y] = 2;
	if( r2.live )	b[r2.x][r2.y] = 2;
	
	if( k1.live )	b[k1.x][k1.y] = 1;
	if( q1.live )	b[q1.x][q1.y] = 1;
	if( r1.live )	b[r1.x][r1.y] = 1;
}

void add( 	chessman k1, chessman q1, chessman r1,
			chessman k2, chessman q2, chessman r2,
			int back )
{
	chess tmp;
	tmp.k1 = k1;
	tmp.q1 = q1;
	tmp.r1 = r1;
	tmp.k2 = k2;
	tmp.q2 = q2;
	tmp.r2 = r2;
	tmp.back = back;
	q.push( tmp );
}

int check( chessman k1, chessman q1, chessman r1, chessman k2, chessman q2, chessman r2, go last )
{
	static board b;
	past( k1,q1,r1,k2,q2,r2,b );
	
	if( k2.live && b[k2.x][k2.y]!=2 ) k2.live = false;
	if( q2.live && b[q2.x][q2.y]!=2 ) q2.live = false;
	if( r2.live && b[r2.x][r2.y]!=2 ) r2.live = false;
	
	if( !k2.live ) game_over( last );
	if( !q1.live && !r1.live && !q2.live && !r2.live ) game_over(last);
	
	if( exit ) return 0;
	
	
	static bool kick[10][10];
	memset( kick, false, sizeof kick );
	
	if( k2.live )
		for(int g=0; g<8; g++)
		{
			int x = k2.x + kx[g];
			int y = k2.y + ky[g];
			if( !on_board(x,y) ) continue;
			kick[x][y] = true;
			if( b[x][y] ) continue;
		}
	if( q2.live )
		for(int g=0; g<8; g++)
			for(int l=1; l<=8; l++)
			{
				int x = q2.x + kx[g]*l;
				int y = q2.y + ky[g]*l;
				if( !on_board(x,y) ) break;
				kick[x][y] = true;
				if( b[x][y] ) break;
			}
	if( r2.live )
		for(int g=0; g<4; g++)
			for(int l=1; l<=8; l++)
			{
				int x = r2.x + rx[g]*l;
				int y = r2.y + ry[g]*l;
				if( !on_board(x,y) ) break;
				kick[x][y] = true;
				if( b[x][y] ) break;
			}

	if( ! kick[k1.x][k1.y] )
	{
		answer.push_back(last);
		add( k2, q2, r2, k1, q1, r1, (int)answer.size()-1 );
		return 1;
	}
	return 0;
}
	

void solve()
{
	board b;
	while( !q.empty() )
	{
		tmp = q.front(); q.pop();
		
		chessman k1 = tmp.k1;
		chessman q1 = tmp.q1;
		chessman r1 = tmp.r1;
		chessman k2 = tmp.k2;
		chessman q2 = tmp.q2;
		chessman r2 = tmp.r2;
		
		int k = 0;
		
		past( k1, q1, r1, k2, q2, r2, b);
		if( k1.live )
		{
			for(int g=0; g<8; g++)
			{
				int x = k1.x + kx[g];
				int y = k1.y + ky[g];
				if( !on_board(x,y) ) continue;
				if( b[x][y] != 1 )
					k += check( chessman(x,y), q1, r1, k2, q2, r2, 
								go('K', k1.x, k1.y, x, y, tmp.back ) );
				if( b[x][y] ) continue;
			}
		}
		if( q1.live )
		{
			for(int g=0; g<8; g++)
				for(int l=1; l<=8; l++)
				{
					int x = q1.x + kx[g]*l;
					int y = q1.y + ky[g]*l;
					if( !on_board(x,y) ) break;
					if( b[x][y] != 1 )
						k += check( k1, chessman(x,y), r1, k2, q2, r2, 
									go( 'Q', q1.x, q1.y, x, y, tmp.back ) );
					if( b[x][y] ) break;
				}
		}
		if( r1.live )
		{
			for(int g=0; g<4; g++)
				for(int l=1; l<=8; l++)
				{
					int x = r1.x + rx[g]*l;
					int y = r1.y + ry[g]*l;
					if( !on_board(x,y) ) break;
					if( b[x][y] != 1 )
						k += check( k1, q1, chessman(x,y), k2, q2, r2,
									go( 'R', r1.x, r1.y, x, y, tmp.back ) );
					if( b[x][y] ) break;
				}
		}
		if( k == 0 )
		{
			if( tmp.back != (-1) )
				game_over( answer[tmp.back] );
			else
				return;
		}
		if( exit ) return;
	}//while
}

void init()
{
	freopen( "chess.in", "r", stdin );
	freopen( "chess.out", "w", stdout );
	
	chess x;
	x.back = -1;
	char t1,t2,x1,x2,y1,y2;
	scanf("%c%c%c %c%c%c\n",&t1,&x1,&y1, &t2,&x2,&y2);
	x.k2 = chessman(x1-'a',y1-'1');
	if( t2 == 'Q' ) 
		x.q2 = chessman(x2-'a',y2-'1');
	else
		x.r2 = chessman(x2-'a',y2-'1');
	
	scanf("%c%c%c %c%c%c\n",&t1,&x1,&y1, &t2,&x2,&y2);
	x.k1 = chessman(x1-'a',y1-'1');
	if( t2 == 'Q' ) 
		x.q1 = chessman(x2-'a',y2-'1');
	else
		x.r1 = chessman(x2-'a',y2-'1');
	
	q.push( x );
}

int main()
{
	init();
	solve();
	return 0;
}
