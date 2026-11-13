#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include "treeunit.h"
using namespace std;
#define forn(i,n) for(int i=0;i<int(n);i++)
#define ford(i,n) for(int i=int(n)-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define sqr(a) ((a)*(a))
#define fs first
#define sc second
#define elif else if

struct edge{
	int x,i;
};

vector <edge> a[200000];

struct _pointer{
	pair <int,int> x,y;
	int _x,_y;
	_pointer(){_x=_y=x.fs=y.fs=x.sc=y.sc=0;}
};

vector <_pointer> ps;

edge me(int x,int y){
	edge a;
	a.x=x;
	a.i=y;
	return a;
}

void m_edge(int x,int y){
	a[--x].push_back(me(--y,ps.size()));
	a[y].push_back(me(x,ps.size()));
	_pointer p;
	p.x.fs=x;
	p.y.fs=y;
	p.x.sc=a[x].size()-1;
	p.y.sc=a[y].size()-1;
	ps.push_back(p);
}

vector <int> leafs;

void find_leafs(int v,int prew){
	forn(i,a[v].size())
		if(a[v][i].x!=prew){
			find_leafs(a[v][i].x,v);
			ps[a[v][i].i]._x=ps[a[v][i].i]._y=0;
		}
	if(a[v].size()==1)
		leafs.push_back(v);
}

int lazy(int v,int prew){
	int res=1;
	forn(i,a[v].size())
		if(a[v][i].x!=prew)
			if(ps[a[v][i].i].x.fs==a[v][i].x){
				if(ps[a[v][i].i]._x==0)
					ps[a[v][i].i]._x=lazy(a[v][i].x,v);
				res+=ps[a[v][i].i]._x;
			}else{
				if(ps[a[v][i].i]._y==0)
					ps[a[v][i].i]._y=lazy(a[v][i].x,v);
				res+=ps[a[v][i].i]._y;
		}
// 	cerr<<res<<' ';
	return res;
}

void the_best(int &a,int b){
	if(a==-1)
		a=b;
	elif(b!=-1 && abs(ps[a]._x-ps[a]._y)>abs(ps[b]._x-ps[b]._y))
		a=b;
}

int dfs(int v,int prew){
	int res=-1;
	forn(i,a[v].size())
		if(a[v][i].x!=prew){
			the_best(res,a[v][i].i);
			the_best(res,dfs(a[v][i].x,v));
		}
// 	cerr<<v<<' '<<res<<endl;
	return res;
}

int get_median(int v){
	if(a[v].size()==0)
		return -1;
	leafs.clear();
	find_leafs(v,-1);
	forn(i,leafs.size()){
		lazy(leafs[i],-1);
// 		cerr<<endl;
	}
	return dfs(leafs[rand()%leafs.size()],-1);
	find_leafs(v,-1);
}

void rec(int v){
// 	cerr<<v<<endl;
	int e=get_median(v);
	if(e==-1){
		report(++v);
		return;
	}
	swap(a[ps[e].x.fs][ps[e].x.sc],a[ps[e].x.fs][a[ps[e].x.fs].size()-1]);
	if(ps[e].x.fs==ps[a[ps[e].x.fs][ps[e].x.sc].i].x.fs)
		ps[a[ps[e].x.fs][ps[e].x.sc].i].x.sc=ps[e].x.sc;
	else
		ps[a[ps[e].x.fs][ps[e].x.sc].i].y.sc=ps[e].x.sc;
	a[ps[e].x.fs].pop_back();
	
	swap(a[ps[e].y.fs][ps[e].y.sc],a[ps[e].y.fs][a[ps[e].y.fs].size()-1]);
	if(ps[e].y.fs==ps[a[ps[e].y.fs][ps[e].y.sc].i].x.fs)
		ps[a[ps[e].y.fs][ps[e].y.sc].i].x.sc=ps[e].y.sc;
	else
		ps[a[ps[e].y.fs][ps[e].y.sc].i].y.sc=ps[e].y.sc;
	a[ps[e].y.fs].pop_back();
	
	if(query(e+1))
		rec(ps[e].y.fs);
	else
		rec(ps[e].x.fs);
}

int main(){
	init();
	int n=getN();
	forn(i,n-1)
		m_edge(getA(i+1),getB(i+1));
	rec(0);
	return 0;
}
