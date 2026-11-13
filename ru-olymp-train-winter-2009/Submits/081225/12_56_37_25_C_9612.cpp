#include "vector"
#include "fstream"
#include "iostream"
#include "math.h"
#include "stdio.h"
#include "algorithm"
#include "string"
#include "stdlib.h"

using namespace std;

struct elem{
	elem*l, *r;
	int size;
	int y;
	int val;
	void rec()
	{
		size = l->size+r->size+1;
	}
};

struct tree2{
	elem *root;
	elem no;
	tree2()
	{
		no.l=no.r=&no;
		no.size=0;
		root = &no;
	}
	void add(int a)
	{
		elem * u = ne();
		u->val = a;
		u->size=1;
		root = add(root, u);
	}
	elem * copy()
	{
		return copy(root);
	}
	void remove(int p)
	{
		root = remove(root, p);
	}
	elem * remove(elem * v, int p)
	{
		if(v == &no)return v;
		//printf("remove %d\n",p);
		if(v->val == p)
		{
			//printf("removed\n");
			return merge(v->l, v->r);
		}
		if(p > v->val)
			v->r = remove(v->r, p);
		else
			v->l = remove(v->l, p);
		v->rec();
		return v;
	}
	elem * copy(elem * v)
	{
		if(v->size == 0)return &no;
		elem * y = ne();
		y->val = v->val;
		y->r = copy(v->r);
		y->l = copy(v->l);
		y->rec();
	}
	elem * add(elem * v, elem * u)
	{
		if(v->size == 0)return u;
		if(u->y > v->y)
		{
			if(v->val < u->val)
				v->r = add(v->r, u);
			else
				v->l = add(v->l, u);
			v->rec();
			return v;
		}
		else
		{
			split(v, u);
			u->rec();
			return u;
		}
	}
	elem * ne()
	{
		elem * u = new elem;
		u->l=&no;
		u->r=&no;
		u->size=0;
		u->val = 0;
		u->y = rand()*rand();
		return u;
	}
	void split(elem * v, elem * a)
	{
		if(v->size == 0){a->l=a->r=&no;return;}
		if(v->val <= a->val)
		{
			split(v->r, a);
			v->r = a->l;
			a->l = v;
		}
		else
		{
			split(v->l, a);
			v->l = a->r;
			a->r = v;
		}
		v->rec();
		a->rec();
	}
	int cnt(int p)
	{
		return cnt(root, p);
	}
	int cnt(elem * v, int p)
	{
		if(v->size == 0)return 0;
		if(v->val <= p)
			return v->l->size + 1 + cnt(v->r, p);
		else
			return cnt(v->l, p);
	}
	elem * merge(elem * a, elem * b)
	{
		if(a->size==0)return b;
		if(b->size==0)return a;
		if(a->y < b->y)
		{
			a->r = merge(a->r, b);
			a->rec();
			return a;
		}
		else
		{
			b->l = merge(a, b->l);
			b->rec();
			return b;
		}
	}
	void print()
	{
		print(root);
	}
	void print(elem *e)
	{
		if(e->size == 0)return;
		print(e->l);
		cout << " " << e->val << "(" << e->size<<") " ;
		print(e->r);
	}
};

struct tree{
	tree2 tr2[400005];
	int size[400005];
	int mx[400005];
	int mn[400005];
	int l[400005];
	int r[400005];
	int val[400005];
	int y[400005];
	int root;
	static const int last=400004;
	int n;
	tree()
	{
	  root=last;
	  size[last]=0;
	  n=0;
	  mx[last] = -10000000;
	  mn[last] = 10000000;
	  l[last]=r[last]=last;
	  val[last]= -10000000;
	}
	void add(int a, int n)
	{
		//printf("adding %d after %d\n", a, n);
		int i = nv();
		size[i]=1;
		mx[i]=a;
		val[i]=a;
		tr2[i].add(a);
		//tr2[i].print();
	//	cout << endl;
		root = add(root, i, n);
		//printf("finished adding");
	}
	int recount(int v)
	{
		mn[v]= min(mn[l[v]], mn[r[v]]);
		mn[v] = min(val[v], mn[v]);
		
		mx[v]= max(mx[l[v]], mx[r[v]]);
		mx[v] = max(val[v], mx[v]);
		size[v] = size[l[v]]+size[r[v]]+1;
	}
	int cnt(){return size[root];}
	int set(int v, int a, int n)
	{
		//printf("seting %d %d %d\n", v, a, n);
		if(size[l[v]] == n-1)
		{
			int t = val[v];
			val[v] = a;
			tr2[v].remove(t);
			tr2[v].add(a);
			recount(v);
			return t;
		}
		int t;
		if(size[l[v]] > n-1)
		{
			t = set(l[v], a, n);
			tr2[v].remove(t);
			tr2[v].add(a);
		}
		else
		{
			t = set(r[v], a, n-size[l[v]]-1);
			tr2[v].remove(t);
			tr2[v].add(a);
		}
		recount(v);
		return t;
	}
	void set(int a, int n)
	{
		set(root, a, n);
	}	
	int add(int v, int i, int n)
	{
		//printf("adding %d in %d after %d\n", i, v, n);
		if(v == last)return i;
		if(y[i]>y[v])
		{
			//printf("go down\n");
			tr2[v].add(val[i]);
			if(n <= size[l[v]])
			{
				l[v] = add(l[v], i, n);
			}
			else
			{
				r[v] = add(r[v], i, n-size[l[v]]-1);
			}
			//printf("finishing %d\n", v);
			recount(v);
			//printf("finished %d\n", v);
			return v;
		}
		else
		{
			vector<int> res = split(v, n);
			l[i] = res[0];
			r[i] = res[1];
			tr2[i].root = tr2[0].merge(tr2[res[0]].copy(), tr2[res[1]].copy());
			tr2[i].add(val[i]);
			recount(i);
			return i;
		}
	}
	vector<int> split(int v, int n)
	{
		//printf("split %d %d\n", v, n);
		vector<int> res(2);
		if(v==last)
		{
			res[0]=res[1]=last;
			return res;
		}
		//printf("left size %d\n", size[l[v]]);
		if(size[l[v]] >= n)
		{
			//printf("go to left\n");
			res = split(l[v], n);
			tr2[v].root = tr2[0].merge(tr2[res[1]].copy(), tr2[r[v]].copy());
			tr2[v].add(val[v]);
			l[v] = res[1];
			res[1]=v;			
		}
		else
		{
			//printf("go to right\n");
			res = split(r[v], n-size[l[v]]-1);
			tr2[v].root = tr2[0].merge(tr2[l[v]].copy(), tr2[res[0]].copy());
			tr2[v].add(val[v]);
			r[v] = res[0];
			res[0] = v;
		}
		recount(v);
		return res;
	}
	int query(int u, int v, int p)
	{
		//printf("QYER");
		return query(root, u, v, p);
	}
	int query(int v, int a, int b, int p)
	{
		//printf("query [%d %d %d %d] %d %d %d\n", val[v], size[v], mx[v], mn[v], a, b, p);
		if(v==last)return 0;
		
		if(b <= 0)
			return 0;
		if(a >= size[v])
			return 0;
		if(a<=0 && b>=size[v])
			return tr2[v].cnt(p);
		int u = (val[v] <= p) && (size[l[v]]>=a)&&(size[l[v]] < b);
		int t = u+query(l[v],a,b,p)+query(r[v],a-size[l[v]]-1,b-size[l[v]]-1,p);
		//printf("return %d\n", t);
		return t;
	}
	int nv()
	{
		l[n]=r[n]=last;
		size[n]=0;
		mx[n]=0;
		mn[n]=0;
		y[n] = rand()*rand();
		return n++;
	}
	void print()
	{
		print(root); 
	}
	void print(int v)
	{
		if(v==last)return;
		cout << "(";
		print(l[v]);
		cout << ")";
		printf("[%d ",val[v]);
		tr2[v].print();
		printf("]",val[v]);
		cout << "(";
		print(r[v]);
		cout << ")";
	}
};

tree tr;
int main()
{	
	
	freopen("dynarray.in", "rt", stdin); 
	freopen("dynarray.out", "wt", stdout);
	//ofstream fout("dynarray.out");
	
	int n, m;
	cin >> n >> m;
	for(int i = 0; i < n; i++)
	{
		int a;
		cin >> a;
		tr.add(a, i);	
		//tr.print();
		//cout << endl;
	}
	bool first=1;
	for(int j = 0; j < m; j++)
	{
		int t;
		cin >> t;
		switch(t)
		{
			case 1:{
				//printf("set\n");
				int u, p;
				cin >> u >> p;
				tr.set(u, p);
				//tr.print();
				//cout << endl;
				}break;	
			case 2:{
				//printf("add\n");
				int u, p;
				cin >> u >> p;
				tr.add(p, u);
				//tr.print();
				//cout << endl;
				}break;
			case 3:{
				//printf("query\n");
				int u, p, v;
				cin >> u >> v >> p;
				cout << tr.query(u-1, v, p)<<endl;
				}break;
		}
	}
	//tr.print();
	//cout << endl;
	//cout << t.cnt() << " " << t.mx[t.root];
	
	return 0;
}